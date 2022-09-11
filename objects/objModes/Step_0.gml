if (fade_start) {
	if (state == -1) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03 * DELTA;
			music_play(bgmModes);
		
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += 0.03 * DELTA;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			
			switch (state) {
				case 0:
					save_file();
					network_disable();
					//room_goto(rFiles);
					break;
					
				case 1: room_goto(rParty); break;
				case 2: room_goto(rMinigames); break;
				case 3: break;
				case 4: room_goto(rSkins); break;
				case 5: room_goto(rTrophies); break;
			}
			
			exit;
		}
	}
}

if (!fade_start) {
	if (mode_selected == -1) {
		mode_selected = mode_prev;
		mode_target_selected = mode_selected;
	}
	
	if (mode_selected != mode_target_selected) {
		mode_x = lerp(mode_x, mode_target_x, 0.5);
	
		if (point_distance(mode_x, 0, mode_target_x, 0) < 1.5) {
			mode_x = 0;
			mode_target_x = mode_x;
			mode_selected = mode_target_selected;
		}
	}
	
	if (mode_selected == mode_target_selected) {
		var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	
		if (scroll_h != 0) {
			mode_target_selected = (mode_selected + array_length(mode_buttons) + scroll_h) % array_length(mode_buttons);
			mode_target_x = 250 * -scroll_h;
			audio_play_sound(global.sound_cursor_move, 0, false);
			exit;
		}
	
		if (mode_buttons[mode_selected].selectable && sync_actions("jump", 1)) {
			global.mode_selected = mode_selected;
			state = mode_selected + 1;
			fade_start = true;
			music_fade();
			audio_play_sound(global.sound_cursor_big_select, 0, false);
			exit;
		}
	
		if (sync_actions("shoot", 1)) {
			back_to_files();
		}
	}
}