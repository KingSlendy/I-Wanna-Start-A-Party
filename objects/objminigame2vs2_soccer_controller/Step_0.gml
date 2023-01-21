if (reset == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		reset = 1;
		action_end();
		
		with (objPlayerBase) {
			x = xstart;
			y = ystart;
			xscale = (x < 400) ? 1 : -1;
		}
		
		with (objMinigame2vs2_Soccer_Ball) {
			x = xstart;
			y = ystart;
			movable = true;
		}
	}
} else if (reset == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		reset = -1;
		alarm_frames(1, 1);
	}
}