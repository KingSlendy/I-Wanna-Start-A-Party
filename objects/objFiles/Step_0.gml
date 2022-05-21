if (fade_start) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		fade_start = false;
	}
}

if (files_fade == 0) {
	files_alpha += 0.04;
	
	if (files_alpha >= 1) {
		files_alpha = 1;
		files_fade = -1;
		online_show = true;
	}
}

for (var i = 0; i < array_length(file_sprites); i++) {
	var target = (i == file_selected) ? 1 : 0.8;
	file_highlights[i] = lerp(file_highlights[i], target, 0.3);
}

if (!fade_start && files_fade == -1) {
	if (file_opened == -1) {
		var scroll = (global.actions.right.pressed() - global.actions.left.pressed());
		var prev_file = file_selected;

		if (file_selected == -1) {
			file_selected = 0;
		}

		file_selected = (file_selected + 3 + scroll) % 3;

		if (file_selected != prev_file) {
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
		
		if (global.actions.jump.pressed()) {
			file_opened = file_selected;
			audio_play_sound(global.sound_cursor_select, 0, false);
		}
	} else {
		var scroll = (global.actions.down.pressed() - global.actions.up.pressed());
		var prev_selected = menu_selected[menu_type];
		var length = array_index(menu_buttons[menu_type], null);
		
		if (length == -1) {
			length = array_length(menu_buttons[menu_type]);
		}
		
		menu_selected[menu_type] = (menu_selected[menu_type] + length + scroll) % length;

		if (menu_selected[menu_type] != prev_selected) {
			audio_play_sound(global.sound_cursor_move, 0, false);
		}
		
		if (global.actions.jump.pressed()) {
			switch (menu_type) {
				case 0:
					if (menu_selected[menu_type] == 0) {
						menu_type = 1;
					} else {
						menu_type = 2;
					}
					break;
					
				case 1:
					if (menu_selected[menu_type] == 0) {
						files_fade = 0;
						finish = true;
					} else {
						online_show = true;
						menu_type = 3;
					}
					break;
					
				case 2:
					menu_type = 0;
					
					//if (menu_selected[menu_type] == 0) {
					//	menu_type = 0;
					//} else {
						
					//}
					break;
					
				case 3:
					var select = menu_selected[menu_type];
	
				
					if (select < 3) {
						var signs = [
							"Enter your name.",
							"Enter the IP.",
							"Enter the port."
						];
						
						online_texts[select] = get_string(signs[select], online_texts[select]);
						
						if (online_limits[select] != -1) {
							online_texts[select] = string_copy(online_texts[select], 1, online_limits[select]);
						}
					} else {
					}
					break;
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			exit;
		}
		
		if (global.actions.shoot.pressed()) {
			switch (menu_type) {
				case 0: file_opened = -1; break;
				case 1: case 2: menu_type = 0; break;
				
				case 3:
					menu_type = 1;
					break;
			}
			
			audio_play_sound(global.sound_cursor_back, 0, false);
		}
	}
}
