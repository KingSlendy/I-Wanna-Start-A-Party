if (global.dice_roll == 0) {
	instance_destroy();
	exit;
}

if (vspeed != 0 && y > ystart) {
	vspeed = 0;
	gravity = 0;
	y = ystart;
}