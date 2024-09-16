if (fade_start) {
	if (state == -1) {
		if (get_player_count(objPlayerParty) == global.player_max) {
			fade_alpha -= 0.03 * DELTA;

			var room_name = room_get_name(room);
			music_play(audio_get_index($"bgm{string_copy(room_name, 2, string_length(room_name) - 1)}"));
	
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
					if (board_selected < array_length(global.boards)) {
						global.board_selected = board_selected;
					} else {
						if (global.player_id == 1) {
							var boards = [];
						
							for (var i = 0; i < array_length(global.boards); i++) {
								if (board_collected(i)) {
									array_push(boards, i);
								}
							}
						
							next_seed_inline();
							array_shuffle_ext(boards);
							global.board_selected = array_pop(boards);
							
							buffer_seek_begin();
							buffer_write_action(ClientTCP.BoardRandom);
							buffer_write_data(buffer_u8, global.board_selected);
							network_send_tcp_packet();
						} else {
							if (global.board_selected == -1) {
								fade_start = true;
								exit;
							}
						}
					}
					
					shuffle_seed_bag();
					reset_seed_inline();
					room_goto(global.boards[global.board_selected].scene);
					exit;
					
				case 1:
					var check = array_get_index(global.all_ai_actions, null);
	
					if (check != -1) {
						array_delete(global.all_ai_actions, check, 1);
					}
				
					room_goto(rModes);
					exit;
					
				case 2:
					with (objPlayerBase) {
						change_to_object(objPlayerBase);
					}
					room_goto(rMinigameOverview);
					exit;
					
				case 3:
					trial_start();
					exit;
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

switch (room) {
	case rParty:
		if (board_selected != board_target_selected) {
			board_x = lerp(board_x, board_target_x, 0.4);
	
			if (point_distance(board_x, 0, board_target_x, 0) < 1.5) {
				board_x = 0;
				board_target_x = board_x;
				board_selected = board_target_selected;
			}
		}
		break;
		
	case rMinigames:
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
		break;
		
	case rTrials:
		if (trials_selected != trials_target_selected) {
			trials_show_y = lerp(trials_show_y, trials_target_show_y, 0.4);
			
			if (point_distance(trials_show_y, 0, trials_target_show_y, 0) < 1.5) {
				trials_show_y = 0;
				trials_target_show_y = trials_show_y;
				trials_selected = trials_target_selected;
			}
		}
		
		if (trials_minigame_selected != trials_minigame_target_selected) {
			trials_show_x = lerp(trials_show_x, trials_target_show_x, 0.4);
			
			if (point_distance(trials_show_x, 0, trials_target_show_x, 0) < 1.5) {
				trials_show_x = 0;
				trials_target_show_x = trials_show_x;
				trials_minigame_selected = trials_minigame_target_selected;
			}
		}
		break;
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
							} until (have_skin(now_skin) && !array_contains(skin_selected, now_skin));
						}
						
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
			switch (room) {
				case rParty:
					if (board_selected == board_target_selected) {
						var scroll = (sync_actions("right", 1) - sync_actions("left", 1));
				
						if (scroll != 0) {
							switch (board_options_selected) {
								case 0:
									var length = array_length(global.boards) + 1;
									board_target_x -= 264 * scroll;
									board_target_selected = (board_selected + length + scroll) % length;
									break;
							
								case 1:
									var turn_total = array_length(turn_list);
									global.max_board_turns = turn_list[(((global.max_board_turns / 5) - 2) + turn_total + scroll) % turn_total];
									break;
									
								case 2: global.give_bonus_shines = !global.give_bonus_shines; break;
							}
					
							audio_play_sound(global.sound_cursor_move, 0, false);
							exit;
						}
				
						if ((global.player_id != 1 || board_options_selected != 0 || (board_collected(board_selected) || board_selected == array_length(global.boards))) && sync_actions("jump", 1)) {
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
					break;
				
				case rMinigames:
					if (minigames_col_selected == minigames_target_col_selected && minigames_row_selected == minigames_target_row_selected) {
						var types = minigame_types();
						var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
	
						if (scroll_h != 0) {
							var length = array_length(global.minigames[$ types[minigames_row_selected]]);
							minigames_target_show_x -= 240 * scroll_h;
							minigames_target_col_selected = (minigames_target_col_selected + length + scroll_h) % length;
							audio_play_sound(global.sound_cursor_move, 0, false);
							exit;
						}
					
						var scroll_v = (sync_actions("down", 1) - sync_actions("up", 1));
					
						if (scroll_v != 0) {
							if ((scroll_v == -1 && minigames_row_selected > 0) || (scroll_v == 1 && minigames_row_selected < array_length(types) - 1)) {
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
						var seen_minigame = minigame_seen(title);
					
						if ((seen_minigame || global.player_id != 1) && sync_actions("jump", 1)) {
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
					break;
					
				case rTrials:
					if (trials_selected == trials_target_selected && trials_minigame_selected == trials_minigame_target_selected) {
						var scroll_v = (sync_actions("down", 1) - sync_actions("up", 1));
						
						if (scroll_v != 0) {
							trials_target_show_y -= draw_h * scroll_v;
							trials_target_selected = (trials_target_selected + array_length(global.trials) + scroll_v) % array_length(global.trials);
							trials_minigame_selected = 0;
							trials_minigame_target_selected = 0;
							audio_play_sound(global.sound_cursor_move, 0, false);
							exit;
						}
						
						var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
						
						if (scroll_h != 0) {
							if ((scroll_h == -1 && trials_minigame_selected > 0) || (scroll_h == 1 && trials_minigame_selected < array_length(global.trials[trials_selected].minigames) - 1)) {
								trials_target_show_x -= 240 * scroll_h;
								trials_minigame_target_selected += scroll_h;
								audio_play_sound(global.sound_cursor_move, 0, false);
								exit;
							}
						}
						
						var trial_playable = true;
						
						if (!trial_collected(trials_selected)) {
							trial_playable = false;
						} else {
							var minigames = global.trials[trials_selected].minigames;
							
							for (var i = 0; i < array_length(minigames); i++) {
								if (!minigame_seen(minigames[i].reference.title)) {
									trial_playable = false;
									break;
								}
							}
						}
						
						if (trial_playable && sync_actions("jump", 1)) {
							trial_info_reset();
							var info = global.trial_info;
							info.reference = global.trials[trials_selected];
							state = 3;
							fade_start = true;
							music_fade();
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
					break;
			}
			break;
			
		case 2:
			var scroll_h = (sync_actions("right", 1) - sync_actions("left", 1));
		
			if (scroll_h != 0) {
				var length = array_length(minigame_turns_permutations);
				minigame_turns_selected = (minigame_turns_selected + scroll_h + length) % length;
				minigame_turns = minigame_turns_permutations[minigame_turns_selected];
				audio_play_sound(global.sound_cursor_move, 0, false);
				exit;
			}
		
			if (sync_actions("jump", 1)) {
				var types = minigame_types();
				
				var team = [];
				
				switch (minigames_row_selected) {
					case 0: array_copy(team, 0, minigame_turns, 0, 4); break; //4vs
					case 1: array_copy(team, 0, minigame_turns, 0, 1); break; //1vs3
					case 2: array_copy(team, 0, minigame_turns, 0, 2); break; //2vs2
				}	
				
				minigame_info_set(minigame_selected.reference, types[minigames_row_selected], minigame_turns, team);
				global.minigame_info.is_minigames = true;
				
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