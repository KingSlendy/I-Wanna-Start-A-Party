switch (state) {
	case 0:
		fade_alpha += 0.03;
	
		if (fade_alpha >= 1) {
			zoom = true;
		
			//Camera points to the middle of the room
			event_perform(ev_step, ev_step_begin);
		
			with (objCamera) {
				view_x = target_follow.x;
				view_y = target_follow.y;
				target_x = view_x;
				target_y = view_y;
			}
		
			//Doubles the view size
			camera_set_view_size(view_camera[0], 800 * 3, 608 * 3);
			fade_alpha = 1;
			state = 1;
			
			instance_destroy(objTurnChoices);
			instance_destroy(objHiddenChest);
		}
		break;
		
	case 1:
		fade_alpha -= 0.05;
	
		if (fade_alpha <= 0) {
			var all_reds = true;
			var all_greens = true;
			var all_different = true;
			
			with (objPlayerInfo) {
				if (all_reds && player_info.space != c_red) {
					all_reds = false;
				}
				
				if (all_greens && player_info.space != c_lime) {
					all_greens = false;
				}
				
				if (all_different) {
					with (objPlayerInfo) {
						if (id == other.id) {
							continue;
						}
						
						if (player_info.space == other.player_info.space) {
							all_different = false;
							break;
						}
					}
				}
			}
			
			if (all_reds) {
				achieve_trophy(24);
			}
			
			if (all_greens) {
				achieve_trophy(70);
			}
			
			if (all_different) {
				achieve_trophy(71);
			}
			
			//Temp
			if (force_type != null) {
				with (objPlayerInfo) {
					player_info.space = c_white;
				}
			}
			//Temp
			
			var color_count = {};
			color_count[$ c_blue] = 0;
			color_count[$ c_red] = 0;
			color_count[$ c_white] = 0;
			
			with (objPlayerInfo) {
				if (player_info.space != c_blue && player_info.space != c_red) {
					color_count[$ c_white]++;
					continue;
				}
				
				color_count[$ player_info.space]++;
			}
			
			var choose_colors = [];
			
			if (color_count[$ c_white] > 0) {
				var types = minigame_types();
				var type_count = {};
			
				for (var i = 0; i < array_length(types); i++) {
					var type = types[i];
					type_count[$ type] = (array_length(global.minigame_type_history) > 0) ? array_count(global.minigame_type_history, type) / array_length(global.minigame_type_history) : 0;
					
					if (type == "4vs") {
						type_count[$ type] *= 0.5;
					}
				}
			
				var min_type = infinity;
			
				for (var i = 0; i < array_length(types); i++) {
					min_type = min(min_type, type_count[$ types[i]]);
				}
				
				var min_types = [];
			
				for (var i = 0; i < array_length(types); i++) {
					if (type_count[$ types[i]] == min_type) {
						array_push(min_types, types[i]);
					}
				}
			
				var chosen_type = min_types[array_length(min_types) - 1];
				
				//Temp
				if (force_type != null) {
					chosen_type = force_type;
				}
				//Temp

				switch (chosen_type) {
					case "4vs":
						switch (color_count[$ c_white]) {
							case 1:
								if (color_count[$ c_blue] == 3 || color_count[$ c_red] == 3) {
									array_push(choose_colors, (color_count[$ c_blue] == 3) ? c_blue : c_red);
								} else {
									array_push(choose_colors, (color_count[$ c_blue] == 1) ? c_blue : c_red);
								}
								break;
								
							case 2:
								if (color_count[$ c_blue] == 2 || color_count[$ c_red] == 2) {
									repeat (2) {
										array_push(choose_colors, (color_count[$ c_blue] == 2) ? c_blue : c_red);
									}
								} else {
									array_push(choose_colors, c_blue, c_red);
								}
								break;
								
							case 3:
								repeat (3) {
									array_push(choose_colors, (color_count[$ c_blue] == 1) ? c_blue : c_red);
								}
								break;
								
							case 4:
								repeat (4) {
									array_push(choose_colors, c_blue);
								}
								break;
						}
						break;
						
					case "1vs3":
						switch (color_count[$ c_white]) {
							case 1:
								if (color_count[$ c_blue] == 3 || color_count[$ c_red] == 3) {
									array_push(choose_colors, (color_count[$ c_blue] == 3) ? c_red : c_blue);
								} else {
									array_push(choose_colors, (color_count[$ c_blue] == 2) ? c_blue : c_red);
								}
								break;
								
							case 2:
								if (color_count[$ c_blue] == 2 || color_count[$ c_red] == 2) {
									array_push(choose_colors, c_blue, c_red);
								} else {
									array_push(choose_colors, c_blue, c_blue);
								}
								break;
								
							case 3:
								repeat (3) {
									array_push(choose_colors, (color_count[$ c_blue] == 1) ? c_red : c_blue);
								}
								break;
								
							case 4:
								array_push(choose_colors, c_blue);
								
								repeat (3) {
									array_push(choose_colors, c_red);
								}
								break;
						}
						break;
						
					case "2vs2":
						switch (color_count[$ c_white]) {
							case 1:
								if (color_count[$ c_blue] == 3 || color_count[$ c_red] == 3) {
									array_push(choose_colors, (color_count[$ c_blue] == 3) ? c_blue : c_red);
								} else {
									array_push(choose_colors, (color_count[$ c_blue] == 1) ? c_blue : c_red);
								}
								break;
								
							case 2:
								if (color_count[$ c_blue] == 2 || color_count[$ c_red] == 2) {
									repeat (2) {
										array_push(choose_colors, (color_count[$ c_blue] == 0) ? c_blue : c_red);
									}
								} else {
									array_push(choose_colors, c_blue, c_red);
								}
								break;
								
							case 3:
								var one_color = (color_count[$ c_blue] == 1) ? c_blue : c_red;
								var two_color = (color_count[$ c_blue] == 1) ? c_red : c_blue;
								array_push(choose_colors, one_color, two_color, two_color);
								break;
								
							case 4:
								array_push(choose_colors, c_blue, c_blue, c_red, c_red);
								break;
						}
						break;
				}
			}
			
			var current_choose = 0;
			
			with (objPlayerInfo) {
				//If there's players with colors other than blue and red, it picks a random one for them
				if (player_info.space != c_blue && player_info.space != c_red && array_length(choose_colors) > 0) {
					player_info.space = choose_colors[current_choose++];
				}
			
				//Gets the count of colors
				array_push(other.player_colors, player_info.space);
			
				//Makes the player info's cards go towards the middle
				var len = 210;
				var dir = point_direction(draw_x + draw_w / 2, draw_y + draw_h / 2, 400, 304);
				target_draw_x = draw_x + lengthdir_x(len, dir);
				target_draw_y = draw_y + lengthdir_y(len, dir) + ((draw_y > 304) ? -50 : 50);
				
				with (other) {
					alarm_call(0, 1);
				}
			}
		
			fade_alpha = 0;
			state = -1;
		}
		break;
		
	case 2:
		minigames_alpha += 0.04;
	
		if (minigames_alpha >= 1) {
			minigames_alpha = 1;
			state = -1;
			alarm_frames(2, 1);
		}
		break;
		
	case 3:
		fade_alpha += 0.01;
		
		if (fade_alpha >= 1) {
			send_to_minigame();
		}
		break;
}