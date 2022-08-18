if (speed != 0) {
	image_speed = (hspeed > 0) ? 1 : -1;
} else {
	image_speed = 0;
}

if (place_meeting(x + hspeed, y, objBlock)) {
	hspeed *= -1;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	vspeed *= -0.75;
}

y = min(y, ystart - 1);

if (abs(vspeed) <= 0.6 && place_meeting(x, y + 1, objBlock)) {
	vspeed = 0;
	gravity = 0;
}