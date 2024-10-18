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
			music_play(bgmSettings);
		}
	}
}

if (room != rSettings) {
	global.ignore_input = (!objGameManager.paused || draw_target_x != 400);
}

if (!fade_start) {
	draw_target_y = 200;
	
	for (var i = 0; i < section_selected; i++) {
		draw_target_y -= 100;
		draw_target_y -= array_length(sections[i].options) * 60;
	}
	
	var section = sections[section_selected];
	draw_target_y -= 60 * section.selected;
	
	if (section.in_option == -1) {
		var scroll_v = (global.actions.down.pressed() - global.actions.up.pressed());

		if (scroll_v != 0) {
			section.selected += scroll_v;
			
			if (section.selected < 0 || section.selected >= array_length(section.options)) {
				section_selected = (section_selected + array_length(sections) + scroll_v) % array_length(sections);
				var new_section = sections[section_selected];
				new_section.selected = (section.selected < 0) ? array_length(new_section.options) - 1 : 0;
				section.selected = 0;
			}
			
			global.ignore_input = true;
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
	} else {
		section.options[section.in_option].check_option();
	}
	
	if (global.actions.jump.pressed()) {
		if (section.in_option == -1) {
			section.in_option = section.selected;
			global.ignore_input = true;
			audio_play_sound(global.sound_cursor_select, 0, false);
		}
	}
	
	if (global.actions.shoot.pressed()) {
		if (section.in_option == -1) {
			if (room == rSettings) {
				fade_start = true;
				back = true;
				music_fade();
			} else {
				draw_target_x += 800;
				global.actions.shoot.consume();
			}
			
			save_config();
		} else {
			if (section.options[section.in_option].label == "LANGUAGE") {
				show_message_async(language_get_text("SETTINGS_GAME_REMEMBER"));
			}
			
			section.in_option = -1;
		}
		
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
}

global.ignore_input = objGameManager.paused;