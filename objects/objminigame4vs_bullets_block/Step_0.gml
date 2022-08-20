if (spin) {
	scale -= 0.05;

	if (scale <= 0.03125) {
		scale = 1;
		image_index++;
		image_index %= image_number;
	}
}