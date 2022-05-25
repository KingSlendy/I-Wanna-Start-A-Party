if (fade_start && get_player_count(objPlayerParty) == global.player_max) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		fade_start = false;
	}
}

if (skin_row != skin_target_row) {
	skin_y = lerp(skin_y, skin_target_y, 0.4);
	
	if (point_distance(skin_y, 0, skin_target_y, 0) < 1.5) {
		skin_y = 118;
		skin_target_y = skin_y;
		skin_row = skin_target_row;
		
		while (skin_col >= array_length(skins[skin_row])) {
			skin_col = (skin_col + skin_show + 1) % skin_show;
		}
	}
}

switch (menu_page) {
	case 0:
		if (skin_row == skin_target_row) {
			var scroll_v = (global.actions.down.pressed() - global.actions.up.pressed());
	
			if (scroll_v != 0) {
				var length = array_length(skins);
				skin_target_y -= 118 * scroll_v;
				skin_target_row = (skin_row + length + scroll_v) % length;
				audio_play_sound(global.sound_cursor_move, 0, false);
				exit;
			}
			
			if (global.actions.jump.pressed()) {
				var now_skin = skins[skin_row][skin_col];
				
				if (array_contains(skin_selected, now_skin)) {
					exit;
				}
				
				skin_selected[skin_player] = now_skin;
				
				with (objPlayerBase) {
					if (network_id == other.skin_player + 1) {
						skin = get_skin(now_skin);
						break;
					}
				}
				
				skin_player++;
				audio_play_sound(global.sound_cursor_select, 0, false);
			}
		}
		
		var scroll_h = (global.actions.right.pressed() - global.actions.left.pressed());
		
		if (scroll_h != 0) {
			var length = array_length(skins[skin_target_row]);
			var prev_col = skin_col;
			skin_col = (skin_col + length + scroll_h) % length;
				
			if (skin_col != prev_col) {
				audio_play_sound(global.sound_cursor_move, 0, false);
			}
		}
		break;
}
