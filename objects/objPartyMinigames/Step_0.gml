if (fade_start) {
	if (state == -1) {
		if (get_player_count(objPlayerParty) == global.player_max) {
			fade_alpha -= 0.03 * DELTA;
			music_play((room == rParty) ? bgmParty : bgmMinigames);
	
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
			}
		}
	} else {
		fade_alpha += ((state == 0) ? 0.0075 : 0.03) * DELTA;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			
			switch (state) {
				case 0:
					global.board_selected = board_selected;
					room_goto(board_rooms[board_selected]);
					break;
					
				case 1:
					var check = array_index(global.all_ai_actions, null);
	
					if (check != -1) {
						array_delete(global.all_ai_actions, check, 1);
					}
				
					room_goto(rModes);
					break;
					
				case 2:
					if (array_length(global.seed_bag) == 0) {
						exit;
					}
				
					with (objPlayerBase) {
						change_to_object(objPlayerBase);
					}
				
					room_goto(rMinigameOverview);
					break;
			}
			
			exit;
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

if (room == rParty) {
	if (board_selected != board_target_selected) {
		board_x = lerp(board_x, board_target_x, 0.4);
	
		if (point_distance(board_x, 0, board_target_x, 0) < 1.5) {
			board_x = 0;
			board_target_x = board_x;
			board_selected = board_target_selected;
		}
	}
} else {
	if (minigames_col_selected != minigames_target_col_selected) {
		minigames_show_x = lerp(minigames_show_x, minigames_target_show_x, 0.4);
	
		if (point_distance(minigames_show_x, 0, minigames_target_show_x, 0) < 1.5) {
			minigames_show_x = 0;
			minigames_target_show_x = minigames_show_x;
			minigames_col_selected = minigames_target_col_selected;
		}
	}
	
	if (minigames_row_selected != minigames_target_row_selected) {
		minigames_show_y = lerp(minigames_show_y, minigames_target_show_y, 0.4);
	
		if (point_distance(minigames_show_y, 0, minigames_target_show_y, 0) < 1.5) {
			minigames_show_y = 0;
			minigames_target_show_y = minigames_show_y;
			minigames_row_selected = minigames_target_row_selected;
		}
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
					var length = ds_list_size(skins);
					skin_target_y -= skin_h * scroll_v;
					skin_target_row = (skin_row + length + scroll_v) % length;
					
					if (skin_col >= ds_list_size(skins[| skin_target_row])) {
						skin_col = ds_list_size(skins[| skin_target_row]) - 1;
					}
					
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
			
				var now_skin = skins[| skin_row][| skin_col];
			
				if (((have_skin(now_skin) || now_skin == noone) || (skin_player + 1 != global.player_id && (!focus_player_by_id(skin_player + 1).ai || !is_player_local(skin_player + 1)))) && !array_contains(skin_selected, now_skin) && sync_actions("jump", skin_player + 1)) {
					if (is_player_local(skin_player + 1)) {
						if (now_skin == noone) {
							do {
								now_skin = irandom(array_length(global.skins) - 1);
							} until ((have_skin(now_skin) || skin_player + 1 != global.player_id) && !array_contains(skin_selected, now_skin));
						}
						
						//skin_selected[skin_player] = now_skin;
						
						with (objPlayerBase) {
							if (network_id == other.skin_player + 1) {
								skin = get_skin(now_skin);
								break;
							}
						}
					}
				
					if (++skin_player == global.player_max) {
						menu_page = 1;
					}
				
					audio_play_sound(global.sound_cursor_select, 0, false);
					exit;
				}
			
				if (sync_actions("shoot", skin_player + 1)) {
					if (skin_player > 0) {
						skin_player--;
						prev_skin_player = skin_player;
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
				var length = ds_list_size(skins[| skin_target_row]);
				var prev_col = skin_col;
				skin_col = (skin_col + length + scroll_h) % length;
				
				if (skin_col != prev_col) {
					audio_play_sound(global.sound_cursor_move, 0, false);
				}
			}
			break;
			
		case 1:
			if (room == rParty) {
				if (board_selected == board_target_selected) {
					var scroll = (sync_actions("right", 1) - sync_actions("left", 1));
				
					if (scroll != 0) {
						switch (board_options_selected) {
							case 0:
								var length = sprite_get_number(sprPartyBoardPictures);
								board_target_x -= 264 * scroll;
								board_target_selected = (board_selected + length + scroll) % length;
								break;
							
							case 1: global.max_board_turns = (global.max_board_turns + 40 + scroll * 10) % 50 + 10; break;
							case 2: global.give_bonus_shines = !global.give_bonus_shines; break;
						}
					
						audio_play_sound(global.sound_cursor_move, 0, false);
						exit;
					}
				
					if (sync_actions("jump", 1)) {
						if (++board_options_selected == 3) {
							board_options_selected = 2;
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
							skin_player = 0;
							prev_skin_player = skin_player;
							skin_selected = array_create(global.player_max, null);
							objPlayerBase.skin = null;
						}
					
						audio_play_sound(global.sound_cursor_back, 0, false);
					}
				}
			} else {
				if (minigames_col_selected == minigames_target_col_selected && minigames_row_selected == minigames_target_row_selected) {
					var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	
					if (scroll_h != 0) {
						var types = minigame_types();
						var length = array_length(global.minigames[$ types[minigames_row_selected]]);
						minigames_target_show_x -= 240 * scroll_h;
						minigames_target_col_selected = (minigames_target_col_selected + length + scroll_h) % length;
						audio_play_sound(global.sound_cursor_move, 0, false);
						exit;
					}
					
					var scroll_v = (sync_actions("down", 1) - sync_actions("up", 1));
					
					if (scroll_v != 0) {
						if (scroll_v == -1 && minigames_row_selected > 0 || scroll_v == 1 && minigames_row_selected < 2) {
							minigames_target_show_y -= 350 * scroll_v;
							minigames_target_row_selected += scroll_v;
							var types = minigame_types();
							var length = array_length(global.minigames[$ types[minigames_target_row_selected]]);
							minigames_col_selected %= length;
							minigames_target_col_selected = minigames_col_selected;
							audio_play_sound(global.sound_cursor_move, 0, false);
							exit;
						}
					}
					
					var names = minigame_types();
					var title = global.minigames[$ names[minigames_row_selected]][minigames_col_selected].title;
					
					if ((array_contains(global.seen_minigames, title) || global.player_id != 1) && sync_actions("jump", 1)) {
						menu_page = 2;
						var minigame = global.minigames[$ names[minigames_row_selected]][minigames_col_selected];
						minigame_selected = {portrait: minigame.portrait, reference: minigame};
						audio_play_sound(global.sound_cursor_select, 0, false);
						exit;
					}
					
					if (sync_actions("shoot", 1)) {
						menu_page = 0;
						skin_player = 0;
						prev_skin_player = skin_player;
						skin_selected = array_create(global.player_max, null);
						objPlayerBase.skin = null;
						audio_play_sound(global.sound_cursor_back, 0, false);
					}
				}
			}
			break;
			
		case 2:
			if (minigames_row_selected != 0) {
				var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
		
				if (scroll_h != 0) {
					var colors = minigame_colors[minigames_row_selected];
				
					if (minigames_row_selected == 1) {
						colors[@ 0] = (colors[0] - 1 + 4 + scroll_h) % 4 + 1;
					} else if (minigames_row_selected == 2) {
						colors[@ 1] = (colors[1] - 2 + 3 + scroll_h) % 3 + 2;
					}
				
					audio_play_sound(global.sound_cursor_move, 0, false);
					exit;
				}
			}
		
			if (sync_actions("jump", 1)) {
				minigame_info_reset();
				var types = minigame_types();
				var info = global.minigame_info;
				info.reference = minigame_selected.reference;
				info.type = types[minigames_row_selected];
				
				if (info.type != "1vs3") {
					info.player_colors = [c_blue, c_red];
				} else {
					info.player_colors = [c_red, c_blue];
				}
				
				info.is_modes = true;
				
				if (IS_ONLINE || array_length(global.player_game_ids) == 0) {
					global.player_game_ids = [null];
				}
				
				for (var i = 1; i <= global.player_max; i++) {
					spawn_player_info(i, i);
				}
				
				if (IS_ONLINE || global.player_game_ids[0] == null) {
					global.player_game_ids = [];
				}
				
				var colors = minigame_colors[minigames_row_selected];
				
				with (objPlayerInfo) {
					player_info.space = (array_contains(colors, player_info.network_id)) ? c_blue : c_red;
					target_draw_x = draw_x;
					target_draw_y = draw_y;
				}
				
				state = 2;
				fade_start = true;
				music_fade();
				audio_play_sound(global.sound_cursor_select, 0, false);
				exit;
			}
		
			if (sync_actions("shoot", 1)) {
				menu_page = 1;
				audio_play_sound(global.sound_cursor_back, 0, false);
			}
			break;
	}
}