event_inherited();

if (state == 0) {
	scale += 0.04;

	if (scale >= 1) {
		scale = 1;
		state = -1;
		alarm[0] = 15;
	}
} else if (state == 1) {
	scale -= 0.05;
	
	if (scale <= 0) {
		instance_destroy();
	}
}