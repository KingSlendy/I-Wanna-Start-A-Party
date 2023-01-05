if (show == 0) {
	portion += spd;
	
	if (portion >= height) {
		portion = height;
		show = -1;
	}
} else if (show == 1) {
	portion -= spd;
	
	if (portion <= 0) {
		portion = 0;
		show = -1;
	}
}