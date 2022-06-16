if (fade_start) {
	if (state == -1) {
		if (get_player_count(objPlayerParty) == global.player_max) {
			fade_alpha -= 0.03;
			music_play((room == rParty) ? bgmParty : bgmMinigames);
	
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += (state == 0) ? 0.0075 : 0.03;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			
			if (state == 0) {
				global.board_selected = board_selected;
				room_goto(board_rooms[board_selected]);
			} else {
				var check = array_index(global.all_ai_actions, null);
	
				if (check != -1) {
					array_delete(global.all_ai_actions, check, 1);
				}
				
				room_goto(rModes);
			}
		}
	}
}

if (skin_row != skin_target_row) {
	skin_y = lerp(skin_y, skin_target_y, 0.4);
	
	if (point_distance(skin_y, 0, skin_target_y, 0) < 1.5) {
		skin_y = skin_h;
		skin_target_y = skin_y;
		skin_row = skin_target_row;
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
		case -1:
			var scroll = (sync_actions("down", 1) - sync_actions("up", 1));
				
			if (scroll != 0) {
				var length = 2;
				save_selected = (save_selected + length + scroll) % length;
				audio_play_sound(global.sound_cursor_move, 0, false);
				exit;
			}
				
			if (sync_actions("jump", 1)) {
				if (save_selected == 0) {
					start_board();
				} else {
					menu_page = 0;
					audio_play_sound(global.sound_cursor_select, 0, false);
				}
				
				exit;
			}
			
			if (sync_actions("shoot", 1)) {
				state = 1;
				fade_start = true;
				music_fade();
				audio_play_sound(global.sound_cursor_back, 0, false);
			}
			break;
		
		case 0:
			if (skin_row == skin_target_row) {
				var scroll_v = (sync_actions("down", skin_player + 1) - sync_actions("up", skin_player + 1));
	
				if (scroll_v != 0) {
					var length = array_length(skins);
					skin_target_y -= skin_h * scroll_v;
					skin_target_row = (skin_row + length + scroll_v) % length;
					
					while (skin_col >= array_length(skins[skin_target_row])) {
						skin_col = (skin_col + skin_target_row + 1) % skin_show;
					}
					
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
			
				if (sync_actions("jump", skin_player + 1)) {
					var now_skin = skins[skin_row][skin_col];
					
					//if (is_player_local(skin_player + 1) && !array_contains(global.collected_skins, now_skin)) {
					//	//audio_play_sound(global.sound_cursor_wrong, 0, false);
					//	exit;
					//}
				
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
					} else {
						if (save_present) {
							menu_page = -1;
						} else {
							state = 1;
							fade_start = true;
							music_fade();
						}
					}
					
					audio_play_sound(global.sound_cursor_back, 0, false);
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
					var length = sprite_get_number(sprPartyBoardPictures);
					board_target_x -= 264 * scroll;
					board_target_selected = (board_selected + length + scroll) % length;
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
				
				if (sync_actions("jump", 1)) {
					if (++board_options_selected == 3) {
						global.player_game_ids = [];
						start_board();
					} else {
						audio_play_sound(global.sound_cursor_select, 0, false);
					}
					
					exit;
				}
				
				if (sync_actions("shoot", 1)) {
					if (--board_options_selected == -1) {
						menu_page = 0;
						board_options_selected = 0;
						skin_selected[skin_player] = null;
				
						with (objPlayerBase) {
							if (network_id == other.skin_player + 1) {
								skin = null;
								break;
							}
						}
					}
					
					audio_play_sound(global.sound_cursor_back, 0, false);
				}
			}
			break;
	}
}
