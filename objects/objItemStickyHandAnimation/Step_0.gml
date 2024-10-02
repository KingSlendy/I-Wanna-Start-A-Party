event_inherited();

if (state == 0) {
	fade_alpha += 0.09;
	
	if (fade_alpha >= 2.5) {
		fade_alpha = 1;
		state = 1;
	}
} else if (state == 1) {
	fade_alpha -= 0.05;
	ypos += 2;
	scale -= 0.05;
	
	if (fade_alpha <= 0) {
		state = -1;
		alarm_frames(1, 1);
	}
}