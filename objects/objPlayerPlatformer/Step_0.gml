#region Movement
grav = grav_amount * orientation;

var dir_left = global.actions[$ left_action].held(network_id);
var dir_right = global.actions[$ right_action].held(network_id);
var dir = 0;

//If the player is frozen no movement is applied
if (!frozen && enable_move) {
    if (dir_right) {
        dir = 1;
	} else if (dir_left) {
        dir = -1;
	}
}

on_block = place_meeting(x, y + orientation, objBlock);
//var on_vineR = (place_meeting(x - 1, y, objVineR) && !on_block);
//var on_vineL = (place_meeting(x + 1, y, objVineL) && !on_block);
var on_vineR = false;
var on_vineL = false;

if (dir != 0) {
	if (!on_vineR && !on_vineL) {
		xscale = dir;
	}
	
	if ((dir == 1 && !on_vineR) || (dir == -1 && !on_vineL)) {
		hspd = max_hspd * dir;
		
		if (trial_is_title(SPEEDY_KID) && network_id == global.player_id) {
			hspd *= 3;
		}
		
		sprite_index = skin[$ "Run"];
	}
} else {
	hspd = 0;
	sprite_index = skin[$ "Idle"];
}

if (!on_platform) {
	if (vspd * orientation < -0.05) {
	    sprite_index = skin[$ "Jump"];
	} else if (vspd * orientation > 0.05) {
	    sprite_index = skin[$ "Fall"];
	}
} else {
	if (!place_meeting(x, y + 4, objPlatform)) {
		on_platform = false;
	}
}

if (room != rMinigame4vs_Drawn && room != rMinigame2vs2_Springing) {
	if (abs(vspd) > max_vspd) {
		vspd = max_vspd * sign(vspd);
	}
} else {
	if (vspd > max_vspd) {
		vspd = max_vspd;
	}
}

if (!frozen) {
	if (enable_jump) {
		if (global.actions[$ jump_action].pressed(network_id)) {
			player_jump();
		}
	
		if (global.actions.jump.released(network_id)) {
			player_fall();
		}
	}
	
	if (enable_shoot && shoot_delay == 0 && global.actions.shoot.pressed(network_id)) {
		player_shoot();
		shoot_delay = get_frames(0.1);
	}
	
	shoot_delay = max(--shoot_delay, 0);

	if (room == rMinigame1vs3_Conveyor) {
		var c = instance_place(x, y + 1, objMinigame1vs3_Conveyor_Conveyor);

		if (c != noone && c.spd != 0) {
			if (hspd == 0 || (sign(hspd) == sign(c.spd))) {
				hspd += c.spd;
			} else {
				hspd = 0;
			}
		}
	}
}
#endregion

#region Collision
//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
vspd += grav;
x += hspd;
y += vspd;

//Collision with block
if (room == rMinigame1vs3_Warping) {
	with (instance_place(x, y, objMinigame1vs3_Warping_Push)) {
		push_block(other.id);
	}
}

var block = instance_place(x, y, objBlock);

if (block != noone) {
	x = xprevious;
	y = yprevious;
	
	if (room == rMinigame1vs3_Hunt) {
		block.touched = true;
	}

	//Detect horizontal collision
	if (place_meeting(x + hspd, y, objBlock)) {
		while (!place_meeting(x + sign(hspd), y, objBlock)) {
			x += sign(hspd);
		}
	
	    hspd = 0;
	}

	//Detect vertical collision
	if (place_meeting(x, y + vspd, objBlock)) {
		while (!place_meeting(x, y + sign(vspd), objBlock)) {
			y += sign(vspd);
		}
	
		if (vspd * orientation > 0) {
			reset_jumps();
		}
		
		if (room == rMinigame1vs3_Avoid && vspd * orientation < 0 && place_meeting(x, y - 1, objMinigame1vs3_Avoid_Block)) {
			with (block) {
				activate(attack);
			}
		}
	
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}
#endregion