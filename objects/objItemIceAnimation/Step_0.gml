event_inherited();

if (state == 0) {
	alpha += 0.09;
	
	if (alpha >= 2.5) {
		alpha = 1;
		state = 1;
	}
} else if (state == 1) {
	alpha -= 0.05;
	ypos += 2;
	scale -= 0.05;
	
	if (alpha <= 0) {
		state = -1;
		alarm_frames(1, 1);
	}
}