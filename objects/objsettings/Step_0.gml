if (fade_start) {
	if (back) {
		fade_alpha += 0.03 * DELTA;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(rFiles);
			exit;
		}
	} else {
		fade_alpha -= 0.03 * DELTA;
	
		if (fade_alpha <= 0) {
			fade_alpha = 0;
			fade_start = false;
			music_play(bgmSettings);
		}
	}
}

if (!fade_start) {
	var section = sections[section_selected];
	
	if (section.in_option == -1) {
		var scroll_h = (global.actions.right.pressed() - global.actions.left.pressed());
	
		if (scroll_h != 0) {
			section_selected = (section_selected + array_length(sections) + scroll_h) % array_length(sections);
			audio_play_sound(global.sound_cursor_move, 0, false);
			exit;
		}
		
		var scroll_v = (global.actions.down.pressed() - global.actions.up.pressed());
	
		if (scroll_v != 0) {
			section.selected = (section.selected + array_length(section.options) + scroll_v) % array_length(section.options);
			audio_play_sound(global.sound_cursor_move, 0, false);
			exit;
		}
	} else {
		section.options[section.in_option].check_option();
	}
	
	if (global.actions.jump.pressed()) {
		if (section.in_option == -1) {
			section.in_option = section.selected;
			audio_play_sound(global.sound_cursor_select, 0, false);
		}
	}
	
	if (global.actions.shoot.pressed()) {
		if (section.in_option == -1) {
			fade_start = true;
			back = true;
			music_fade();
			save_config();
		} else {
			section.in_option = -1;
		}
		
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}