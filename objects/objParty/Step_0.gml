if (fade_start && get_player_count(objPlayerParty) == global.player_max) {
	if (!finish) {
		fade_alpha -= 0.03;
	
		if (fade_alpha <= 0) {
			fade_alpha = 0;
			fade_start = false;
		}
	} else {
		fade_alpha += 0.01;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			room_goto(board_rooms[board_selected]);
		}
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

if (board_selected != board_target_selected) {
	board_x = lerp(board_x, board_target_x, 0.4);
	
	if (point_distance(board_x, 0, board_target_x, 0) < 1.5) {
		board_x = 0;
		board_target_x = board_x;
		board_selected = board_target_selected;
	}
}

if (!fade_start && point_distance(menu_x, 0, -menu_sep * menu_page, 0) < 1.5) {
	switch (menu_page) {
		case 0:
			if (skin_row == skin_target_row) {
				var scroll_v = (sync_actions("down", skin_player + 1) - sync_actions("up", skin_player + 1));
	
				if (scroll_v != 0) {
					var length = array_length(skins);
					skin_target_y -= 118 * scroll_v;
					skin_target_row = (skin_row + length + scroll_v) % length;
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
			
				if (sync_actions("jump", skin_player + 1)) {
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
				
					if (skin_player < 3) {
						skin_player++;
					} else {
						menu_page = 1;
					}
				
					audio_play_sound(global.sound_cursor_select, 0, false);
					exit;
				}
			
				if (sync_actions("shoot", skin_player + 1)) {
					if (skin_player > 0) {
						skin_player--;
						skin_selected[skin_player] = null;
				
						with (objPlayerBase) {
							if (network_id == other.skin_player + 1) {
								skin = null;
								break;
							}
						}
				
						audio_play_sound(global.sound_cursor_back, 0, false);
					} else {
						//Send to mode selection
					}
				}
			}
		
			var scroll_h = (sync_actions("right", skin_player + 1) - sync_actions("left", skin_player + 1));
		
			if (scroll_h != 0) {
				var length = array_length(skins[skin_target_row]);
				var prev_col = skin_col;
				skin_col = (skin_col + length + scroll_h) % length;
				
				if (skin_col != prev_col) {
					audio_play_sound(global.sound_cursor_move, 0, false);
				}
			}
			break;
			
		case 1:
			if (board_selected == board_target_selected) {
				var scroll = (sync_actions("right", 1) - sync_actions("left", 1));
				
				if (scroll != 0) {
					var length = sprite_get_number(sprPartyBoardTest);
					board_target_x -= 264 * scroll;
					board_target_selected = (board_selected + length + scroll) % length;
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
				
				if (sync_actions("jump", 1)) {
					finish = true;
					fade_start = true;
					exit;
				}
				
				if (sync_actions("shoot", 1)) {
					menu_page = 0;
					skin_selected[skin_player] = null;
				
					with (objPlayerBase) {
						if (network_id == other.skin_player + 1) {
							skin = null;
							break;
						}
					}
				
					audio_play_sound(global.sound_cursor_back, 0, false);
				}
			}
			break;
	}
}
