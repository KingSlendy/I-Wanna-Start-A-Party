grav = grav_amount;

on_block = place_meeting(x, y + 1, objBlock);

if (hspd != 0) {
	sprite_index = skin[$ "Run"];
	xscale = sign(hspd);
} else {
	sprite_index = skin[$ "Idle"];
}

if (vspd < -0.05) {
	sprite_index = skin[$ "Jump"];
} else if (vspd > 0.05) {
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
	}
}

//Storing the previous x and y
xprevious = x;
yprevious = y;

//Moving the player manually
vspd += grav;
x += hspd;
y += vspd;

if (room == rMinigame4vs_Bullets && hspd != 0) {
	if (advance) {
		if (x <= 238) {
			x = 238;
			hspd = 0;
			frozen = false;
			advance = false;
		}
	} else {
		if (x <= 174) {
			x = 174;
			hspd = 0;
		}
	}
	
	if (x >= xstart) {
		x = xstart;
		hspd = 0;
		xscale = -1;
	}
}

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
	
		if (vspd > 0) {
			reset_jumps();
			
			if (room == rMinigame4vs_Leap) {
				hspd = 0;
				var turn = player_info_by_id(other.network_id).turn - 1;
					
				if (objMinigameController.reset_input[turn] != 0 && alarm_is_stopped(1)) {
					alarm_frames(1, 2);
				}
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
