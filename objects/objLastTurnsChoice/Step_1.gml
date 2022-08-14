if (vspeed != 0 && y > ystart) {
	vspeed = 0;
	gravity = 0;
	y = ystart;
	alarm_call(0, 0.3);
}