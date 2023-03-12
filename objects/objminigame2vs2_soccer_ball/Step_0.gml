if (speed != 0) {
	image_speed = (hspeed > 0) ? 1 : -1;
} else {
	image_speed = 0;
}

if (place_meeting(x, y + 1, objBlock)) {
	if (abs(vspeed) <= 0.6) {
		vspeed = 0;
		gravity = 0;
	}
} else {
	if (speed != 0) {
		gravity = 0.4;
	}
}