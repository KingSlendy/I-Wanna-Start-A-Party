if (fade_start) {
	if (global.lobby_started || back || back_option) {
		fade_alpha += 0.02;
	
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			
			if (back) {
				room_goto(rTitle);
			}
			
			if (global.lobby_started) {
				room_goto(rModes);
			}
			
			if (back_option) {
				room_goto(rSettings);
			}
			
			exit;
		}
	} else {
		fade_alpha -= 0.03;
	
		if (fade_alpha <= 0) {
			fade_alpha = 0;
			fade_start = false;
			music_play(bgmFiles);
		}
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
	var target = (i == global.file_selected) ? 1 : 0.75;
	file_highlights[i] = lerp(file_highlights[i], target, 0.3);
}

if (!fade_start && files_fade == -1 && !global.lobby_started) {
	if (file_opened == -1) {
		if (global.file_selected == -1 && option_selected == -1) {
			global.file_selected = files_prev;
		}

		var scroll = (global.actions.right.pressed() - global.actions.left.pressed());

		if (global.file_selected != -1) {
			var prev = global.file_selected;
			global.file_selected = (global.file_selected + array_length(file_sprites) + scroll) % array_length(file_sprites);

			if (global.file_selected != prev) {
				audio_play_sound(global.sound_cursor_move, 0, false);
				exit;
			}
		} else {
			var prev = option_selected;
			option_selected = (option_selected + array_length(option_buttons) + scroll) % array_length(option_buttons);

			if (option_selected != prev) {
				audio_play_sound(global.sound_cursor_move, 0, false);
				exit;
			}
		}
		
		if (global.actions.down.pressed() || global.actions.up.pressed()) {
			if (global.file_selected != -1) {
				option_selected = global.file_selected;
				global.file_selected = -1;
			} else {
				global.file_selected = option_selected;
				option_selected = -1;
			}
			
			audio_play_sound(global.sound_cursor_move, 0, false);
			exit;
		}
		
		if (global.actions.jump.pressed()) {
			if (global.file_selected != -1) {
				file_opened = global.file_selected;
				load_file();
				file_name = global.player_name;
				online_texts = [
					global.ip,
					global.port
				];
			} else {
				switch (option_selected) {
					case 0:
						fade_start = true;
						back_option = true;
						music_fade();
						audio_play_sound(global.sound_cursor_big_select, 0, false);
						exit;
					
					case 1:
						execute_shell_simple("https://discord.gg/dQsUg2g3P2",,, 0);
						break;
						
					case 2:
						execute_shell_simple("https://iwannastartaparty.com/",,, 0);
						break;
				}
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			exit;
		}
		
		if (global.actions.shoot.pressed()) {
			fade_start = true;
			back = true;
			music_fade();
			audio_play_sound(global.sound_cursor_back, 0, false);
		}
	} else if (!online_reading) {
		if (!lobby_seeing) {
			var scroll = (global.actions.down.pressed() - global.actions.up.pressed());
			
			if (menu_type == 5 && global.player_id != 1) {
				scroll = 0;
			}
			
			var prev_selected = menu_selected[menu_type];
			var length = array_index(menu_buttons[menu_type], null);
		
			if (length == -1) {
				length = array_length(menu_buttons[menu_type]);
			}
		
			menu_selected[menu_type] = (menu_selected[menu_type] + length + scroll) % length;
		
			if (menu_selected[menu_type] != prev_selected) {
				audio_play_sound(global.sound_cursor_move, 0, false);
			}
		} else {
			var scroll = (global.actions.down.pressed() - global.actions.up.pressed());
			var prev_selected = lobby_selected;
			var length = array_length(lobby_list);
			lobby_selected = (lobby_selected + length + scroll) % length;
		
			if (lobby_selected != prev_selected) {
				audio_play_sound(global.sound_cursor_move, 0, false);
			}
		}
		
		if (global.actions.jump.pressed()) {
			if (!lobby_seeing) {
				switch (menu_type) {
					case 0:
						switch (menu_selected[menu_type]) {
							case 0: menu_type = 1; break;
							case 1: menu_type = 6; break;
							case 2: menu_type = 2; break;
						}
						
						menu_selected[menu_type] = 0;
						break;
					
					case 1:
						var select = menu_selected[menu_type];
						global.player_name = file_name;
					
						if (select == 0) {
							global.player_id = 1;
							player_join_all();
							ai_join_all();
							global.lobby_started = true;
							fade_start = true;
							generate_seed_bag();
							music_fade();
							audio_play_sound(global.sound_cursor_big_select, 0, false);
							exit;
						} else if (select == 1) {
							online_show = true;
							menu_type = 3;
							upper_type = menu_type;
							upper_text = "ONLINE DATA";
						} else {
							file_name = "";
							var text = get_string("Enter your name.", file_name);
							
							for (var i = 1; i <= string_length(text); i++) {
								var char = string_char_at(text, i);
								
								if (char == " " || char == "." || char == "!" || char == "?") {
									file_name += char;
								}
								
								file_name += string_letters(char) + string_digits(char);
							}
							
							file_name = string_trim(file_name);
						
							if (string_length(file_name) == 0) {
								file_name = DEFAULT_PLAYER;
							}
						
							if (file_limit != -1) {
								file_name = string_copy(file_name, 1, file_limit);
							}
						}
						break;
					
					case 2:
						if (menu_selected[menu_type] == 0) {
							menu_type = 0;
						} else {
							delete_file();
							file_sprite(file_opened);
							file_opened = -1;
						}
						
						menu_type = 0;
						menu_selected[menu_type] = 0;
						break;
					
					case 3:
						var select = menu_selected[menu_type];
	
						if (select < 2) {
							var signs = [
								"Enter the IP.",
								"Enter the port. (0~9)"
							];
						
							online_texts[select] = "";
							var text = get_string(signs[select], online_texts[select]);
							
							for (var i = 1; i <= string_length(text); i++) {
								var char = string_char_at(text, i);
								
								if (select == 1) {
									online_texts[select] += string_digits(char);
								} else {
									online_texts[select] += char;
								}
							}
							
							online_texts[select] = string_trim(online_texts[select]);
						
							if (string_length(online_texts[select]) == 0) {
								switch (select) {
									case 0: online_texts[select] = DEFAULT_IP; break;
									case 1: online_texts[select] = DEFAULT_PORT; break;
								}
							}
						
							if (online_limits[select] != -1) {
								online_texts[select] = string_copy(online_texts[select], 1, online_limits[select]);
							}
						} else {
							if (!IS_ONLINE) {
								global.ip = online_texts[0];
								global.port = online_texts[1];
								online_reading = true;
								instance_create_layer(0, 0, "Managers", objNetworkClient);
							}
						}
						break;
					
					case 4:
						var select = menu_selected[menu_type];
	
						if (select < 2) {
							var signs = [
								"Enter the lobby's name.",
								"Enter the password. (A~Z) (0~9)"
							];
						
							lobby_texts[select] = "";
							var text = get_string(signs[select], lobby_texts[select]);
							
							for (var i = 1; i <= string_length(text); i++) {
								var char = string_char_at(text, i);
								
								if (select == 0 && (char == " " || char == "!" || char == "?")) {
									lobby_texts[select] += char;
								}
								
								lobby_texts[select] += string_letters(char) + string_digits(char);
							}
							
							lobby_texts[select] = string_trim(lobby_texts[select]);
							
							if (select == 0 && string_length(lobby_texts[select]) == 0) {
								lobby_texts[select] = "Room";
							}
						
							if (lobby_limits[select] != -1) {
								lobby_texts[select] = string_copy(lobby_texts[select], 1, lobby_limits[select]);
							}
						} else {
							if (select == 2 || (select == 3 && array_length(lobby_list) > 0)) {
								buffer_seek_begin();
								buffer_write_action((select == 2) ? ClientTCP.CreateLobby : ClientTCP.JoinLobby);
								buffer_write_data(buffer_u64, global.master_id);
								buffer_write_data(buffer_text, lobby_texts[0] + "|" + sha1_string_utf8(lobby_texts[1]));
								network_send_tcp_packet();
								online_reading = true;
							} else if (select == 4 && array_length(lobby_list) > 0) {
								menu_selected[menu_type] = -1;
								lobby_seeing = true;
							} else if (select == 5) {
								online_reading = true;
								buffer_seek_begin();
								buffer_write_action(ClientTCP.LobbyList);
								network_send_tcp_packet();
							}
						}
						break;
						
					case 5:
						if (menu_selected[menu_type] == 0) {
							if (global.player_id != 1 || alarm[0] != -1 || global.lobby_started) {
								exit;
							}
						
							var player_count = 0;
						
							with (objPlayerBase) {
								player_count += online;
							}
						
							if (player_count < 2) {
								exit;
							}
						
							ai_join_all();
							alarm[0] = get_frames(1);
							music_fade();
							audio_play_sound(global.sound_cursor_big_select, 0, false);
						
							buffer_seek_begin();
							buffer_write_action(ClientUDP.LobbyStart);
							network_send_udp_packet();
						} else {
							audio_play_sound(global.sound_cursor_select, 0, false);
							
							buffer_seek_begin();
							buffer_write_action(ClientTCP.LobbyKick);
							buffer_write_data(buffer_u8, menu_selected[menu_type] + 1);
							network_send_tcp_packet();
							
							menu_selected[menu_type] = 0;
						}
						exit;
						
					case 6:
						if (menu_selected[menu_type] == 0) {
							menu_type = 0;
						} else {
							restore_file();
							file_sprite(file_opened);
							file_opened = -1;
						}
						
						menu_type = 0;
						menu_selected[menu_type] = 0;
						break;
				}
			} else {
				var lobby = lobby_list[lobby_selected];
				lobby_texts[0] = lobby.name;
				
				if (!lobby.has_password) {
					menu_selected[menu_type] = 3;
				} else {
					menu_selected[menu_type] = 1;
				}
				
				lobby_seeing = false;
			}
			
			audio_play_sound(global.sound_cursor_select, 0, false);
			exit;
		}
		
		if (!lobby_return && !global.lobby_started && global.actions.shoot.pressed()) {
			if (!lobby_seeing) {
				switch (menu_type) {
					case 0: file_opened = -1; break;
					case 2:
						menu_selected[menu_type] = 0;
						
					case 1:
						menu_type = 0;
						menu_selected[menu_type] = 0;
						break;
						
					case 3: menu_type = 1; break;
					
					case 4:
						menu_type = 3;
						upper_type = menu_type;
						upper_text = "ONLINE DATA";
						instance_destroy(objNetworkClient);
						break;
						
					case 5:
						lobby_leave();
						break;
						
					case 6:
						menu_selected[menu_type] = 0;
						menu_type = 0;
						menu_selected[menu_type] = 0;
						break;
				}
			} else {
				menu_selected[menu_type] = 4;
				lobby_seeing = false;
			}
			
			audio_play_sound(global.sound_cursor_back, 0, false);
		}
	}
}