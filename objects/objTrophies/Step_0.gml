if (fade_start) {
	if (!back) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03;
			music_play(bgmTrophies);
		
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += 0.03;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(rModes);
		}
	}
}

if (trophy_selected != trophy_target_selected) {
	trophy_x = lerp(trophy_x, trophy_target_x, 0.4);

	if (point_distance(trophy_x, 0, trophy_target_x, 0) < 1.5) {
		trophy_x = 400;
		trophy_target_x = trophy_x;
		trophy_selected = trophy_target_selected;
	}
}

if (!fade_start && trophy_selected == trophy_target_selected) {
	var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	
	if (scroll_h != 0) {
		trophy_target_x -= 200 * scroll_h;
		trophy_target_selected = (trophy_selected + array_length(global.trophies) + scroll_h) % array_length(global.trophies);
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	if (sync_actions("shoot", 1)) {
		back = true;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}
