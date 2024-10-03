if (place_meeting(x + hspeed, y, objBlock)) {
	hspeed *= -1;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	vspeed *= -1;
}