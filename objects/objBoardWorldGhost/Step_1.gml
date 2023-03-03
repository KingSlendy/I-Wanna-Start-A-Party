if (vspeed > 0 && y >= jump_y) {
	vspeed = 0;
	gravity = 0;
	y = jump_y;
}