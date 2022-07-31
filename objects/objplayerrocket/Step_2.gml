if (place_meeting(x + hspeed, y, objBlock)) {
	hspeed *= -0.8;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	vspeed *= -0.8;
}

event_inherited();