if (state == 0) {
	scale += 0.05;
	
	if (scale >= 1) {
		scale = 1;
		state = -1;
	}
} else if (state == 1) {
	scale -= 0.05;
	
	if (scale <= 0) {
		scale = 0;
		state = -1;
	}
}