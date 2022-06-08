if (fade_start == 0) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		fade_start = 1;
	}
} else if (fade_start == 1) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		instance_destroy();
	}
}
