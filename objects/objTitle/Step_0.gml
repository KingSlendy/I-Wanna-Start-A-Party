if (fade_start) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		title_start = true;
	}
}

if (title_start) {
	title_alpha += 0.03;

	if (title_alpha >= 1) {
		title_alpha = 1;
	}

	title_scale -= 0.07;

	if (title_scale <= 1) {
		title_scale = 1;
	}
}
