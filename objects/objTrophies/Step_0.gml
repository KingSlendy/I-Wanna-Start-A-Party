if (fade_start) {
	if (!back) {
		if (get_player_count(objPlayerBase) == global.player_max) {
			fade_alpha -= 0.03 * DELTA;
			music_play(bgmTrophies);
		
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
			room_goto(rModes);
			exit;
		}
	}
}

if (trophy_selected != trophy_target_selected) {
	trophy_x = lerp(trophy_x, trophy_target_x, (held_time == 25) ? 0.6 : 0.4);

	if (point_distance(trophy_x, 0, trophy_target_x, 0) < 1.5) {
		trophy_x = 400;
		trophy_target_x = trophy_x;
		trophy_selected = trophy_target_selected;
	}
}

if (!fade_start && trophy_selected == trophy_target_selected) {
	var held_h = (global.actions.right.held() - global.actions.left.held());
	
	if (held_h != 0) {
		held_time = min(++held_time, 25);
	} else {
		held_time = 0;
	}
	
	var scroll_h = (global.actions.right.pressed() - global.actions.left.pressed());
	
	if (held_h == 0) {
		held_h = scroll_h;	
	}
	
	if ((held_h != 0 && held_time == 25) || scroll_h != 0) {
		trophy_target_x -= 200 * held_h;
		trophy_target_selected = (trophy_selected + array_length(global.trophies) + held_h) % array_length(global.trophies);
		audio_play_sound(global.sound_cursor_move, 0, false);
		exit;
	}
	
	var trophy = global.trophies[trophy_selected];
	
	if (!achieved_trophy(trophy.image - 1) && !spoilered_trophy(trophy.image - 1) && global.actions.jump.pressed()) {
		var price = 0;
		
		if (trophy.state() == TrophyState.Unknown) {
			price = global.trophy_hint_price;
		} else {
			price = global.trophy_spoiler_price;
		}
		
		if (global.collected_coins >= price) {
			if (trophy.state() == TrophyState.Unknown) {
				hint_trophy(trophy.image - 1);
			} else {
				spoiler_trophy(trophy.image - 1);
			}
			
			change_collected_coins(-price);
			save_file();
			audio_play_sound(global.sound_cursor_select2, 0, false);
			exit;
		}
	}
	
	if (global.actions.shoot.pressed()) {
		back = true;
		fade_start = true;
		music_fade();
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}