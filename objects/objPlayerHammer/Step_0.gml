if (frozen) {
	exit;
}

var h = (global.actions.right.held(network_id) - global.actions.left.held(network_id));
var v = (global.actions.down.held(network_id) - global.actions.up.held(network_id));
hspd = h * max_spd;
vspd = v * max_spd;

if (index == 0 && can_hit && global.actions.shoot.pressed(network_id)) {
	index = 1;
	can_hit = false;
	audio_play_sound(sndMinigame2vs2_Idol_Hit, 0, false);
	alarm_call(0, 0.1);
	alarm_call(1, 0.4);
}

#region Collision
xprevious = x;
yprevious = y;

x += hspd;
y += vspd;

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
	
	    vspd = 0;
	}

	//Detect diagonal collision
	if (place_meeting(x + hspd, y + vspd, objBlock)) {
		hspd = 0;
	}

	x += hspd;
	y += vspd;
}
#endregion