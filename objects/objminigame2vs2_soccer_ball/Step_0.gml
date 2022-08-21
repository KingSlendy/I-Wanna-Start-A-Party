if (speed != 0) {
	image_speed = (hspeed > 0) ? 1 : -1;
} else {
	image_speed = 0;
}

if (abs(vspeed) <= 0.6 && place_meeting(x, y + 1, objBlock)) {
	//y = ystart - 1;
	vspeed = 0;
	gravity = 0;
}