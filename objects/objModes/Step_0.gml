if (fade_start) {
	if (state == -1) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03;
			music_play(bgmModes);
		
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
			
			switch (state) {
				case 0:
					network_disable();
					room_goto(rFiles);
					break;
					
				case 1: room_goto(rParty); break;
				case 2: room_goto(rMinigames); break;
				case 3: room_goto(rSkins); break;
			}
		}
	}
}

if (!fade_start) {
	if (mode_selected == -1) {
		mode_selected = 0;
	}
	
	var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	var scroll_v = (sync_actions("down", 1) - sync_actions("up", 1));
	
	if (scroll_h != 0) {
		scroll_v = 0;
		mode_selected = (mode_selected + array_length(mode_buttons) + scroll_h * 2) % array_length(mode_buttons);
		audio_play_sound(global.sound_cursor_move, 0, false);
	}
	
	if (scroll_v != 0) {
		var selected = (mode_selected + 2 + scroll_v) % 2;
		
		if (mode_selected > 1) {
			selected += 2;
		}
		
		mode_selected = selected;
		audio_play_sound(global.sound_cursor_move, 0, false);
	}
	
	if (sync_actions("jump", 1)) {
		global.mode_selected = mode_selected;
		state = mode_selected + 1;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_big_select, 0, false);
	}
	
	if (sync_actions("shoot", 1)) {
		state = 0;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}
