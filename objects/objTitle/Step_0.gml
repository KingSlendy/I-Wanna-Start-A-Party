if (fade_start) {
	if (!pressed) {
		fade_alpha -= 0.03;
	
		if (fade_alpha <= 0) {
			fade_alpha = 0;
			title_start = true;
			fade_start = false;
			alarm_frames(0, 1);
			music_play(bgmTitle);
		}
	} else {
		fade_alpha += 0.02;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			room_goto(rFiles);
			exit;
		}
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

if (!fade_start && global.actions.jump.pressed()) {
	audio_play_sound(sndTitleSelect, 0, false);
	music_stop();
	fade_start = true;
	pressed = true;
}