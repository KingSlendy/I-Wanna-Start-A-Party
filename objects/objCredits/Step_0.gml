if (fade_start) {
	if (back) {
		fade_alpha += 0.03;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(rFiles);
			exit;
		}
	} else {
		fade_alpha -= 0.03;
	
		if (fade_alpha <= 0) {
			fade_alpha = 0;
			fade_start = false;
			//music_play(bgmCredits);
		}
	}
}

if (!fade_start) {
	if (global.actions.jump.pressed() || global.actions.shoot.pressed()) {
		fade_start = true;
		back = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}