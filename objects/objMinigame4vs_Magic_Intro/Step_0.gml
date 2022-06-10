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
} else if (fade_start == 2) {
	fade_alpha += 0.03;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		fade_start = 1;
		draw_views = false;
		objMinigameController.minigame_time = 40;
	}
}

if (quake) {
	show_view_x = irandom_range(-5, 5);
	show_view_y = irandom_range(-5, 5);
}
