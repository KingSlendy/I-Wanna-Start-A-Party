#region Movement
grav = grav_amount * orientation;

var dir_left = global.actions.left.held(network_id);
var dir_right = global.actions.right.held(network_id);
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
		sprite_index = skin[$ "Run"];
	}
} else {
	hspd = 0;
	sprite_index = skin[$ "Idle"];
}

if (vspd * orientation < -0.05) {
    sprite_index = skin[$ "Jump"];
} else if (vspd * orientation > 0.05) {
    sprite_index = skin[$ "Fall"];
}

if (abs(vspd) > max_vspd) {
	vspd = max_vspd * sign(vspd);
}

if (!frozen) {
	if (enable_jump) {
		if (global.actions.jump.pressed(network_id)) {
			player_jump();
		}
	
		if (global.actions.jump.released(network_id)) {
			player_fall();
		}
	}
	
	if (enable_shoot && global.actions.shoot.pressed(network_id)) {
		player_shoot();
	}
	
	//if (on_vineR || on_vineL) {
	//	xscale = (on_vineR) ? 1 : -1;
	//    vspd = 2 * global.grav;
	//	image_speed = 0.5;
	//    sprite_index = PLAYER_ACTIONS.SLIDE;
    
	//    if ((on_vineR && is_pressed(global.controls.right)) || (on_vineL && is_pressed(global.controls.left))) {
	//        if (is_held(global.controls.jump)) {
	//            hspd = (on_vineR) ? 15 : -15;
	//            vspd = -9 * global.grav;
	//            sprite_index = PLAYER_ACTIONS.JUMP;
	//			audio_play_sound(sndVine, 0, false);
	//        } else {
	//            hspd = (on_vineR) ? 3 : -3;
	//            sprite_index = PLAYER_ACTIONS.FALL;
	//        }
	//    }
	//}
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
var block = instance_place(x, y, objBlock);

if (block != noone) {
	x = xprevious;
	y = yprevious;

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
	
	    vspd = 0;
		grav = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
	
	////Makes player move based on the block speed
	//if (!place_meeting(x + block.hspd, y, objBlock)) {
	//	x += block.hspd;
	//}
	
	//y += block.vspd;
}

////Collision with platform
//var platform = instance_place(x, y + vspd, objPlatform);

//if (platform != noone && vspd * global.grav > 0) {
//	if (global.grav == 1) {
//		var bbox_check = (bbox_bottom - max(1, abs(vspd)) <= platform.bbox_top);
//	} else {
//		var bbox_check = (bbox_top + max(1, abs(vspd)) >= platform.bbox_bottom);
//	}

//	if (bbox_check) {
//		y = yprevious;
		
//		//Detect vertical collision
//		if (place_meeting(x, y + vspd, objPlatform)) {
//			while (!place_meeting(x, y + global.grav, objPlatform)) {
//				y += global.grav;
//			}

//		    vspd = 0;
//			grav = 0;
//			reset_jumps();
//		}
	
//		y += vspd;
		
//		//Makes player move based on the platform speed
//		if (!place_meeting(x + platform.hspd, y, objBlock)) {
//			x += platform.hspd;
//		}
	
//		y += platform.vspd;
//	}
//}
#endregion