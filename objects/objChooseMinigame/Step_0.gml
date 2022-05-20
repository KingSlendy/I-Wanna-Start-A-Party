switch (state) {
	case 0:
		alpha += 0.03;
	
		if (alpha >= 1) {
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
			camera_set_view_size(view_camera[0], 800 * 2.5, 608 * 2.5);
			alpha = 1;
			state = 1;
			
			instance_destroy(objTurnChoices);
			instance_destroy(objHiddenChest);
		}
		break;
		
	case 1:
		alpha -= 0.05;
	
		if (alpha <= 0) {
			//Temp
			//var test2 = 2//irandom(2);
			//var test = [1, 2, 3, 4];
			//array_shuffle(test);
			//array_delete(test, 2, test2);
			//Temp
			
			with (objPlayerInfo) {
				//Temp
				//if (array_contains(test, player_info.turn)) {
				//	player_info.space = c_blue;
				//} else {
				//	player_info.space = c_red;
				//}
				//Temp
			
				//If there's players with colors other than blue and red, it picks a random one for them
				if (player_info.space != c_blue && player_info.space != c_red) {
					player_info.space = choose(c_blue, c_red);
				}
			
				//Gets the count of colors
				array_push(other.player_colors, player_info.space);
			
				//Makes the player info's cards go towards the middle
				var len = 210;
				var dir = point_direction(draw_x + draw_w / 2, draw_y + draw_h / 2, 400, 304);
				target_draw_x = draw_x + lengthdir_x(len, dir);
				target_draw_y = draw_y + lengthdir_y(len, dir) + ((draw_y > 304) ? -50 : 50);
				other.alarm[0] = get_frames(1);
			}
		
			alpha = 0;
			state = -1;
		}
		break;
		
	case 2:
		minigames_alpha += 0.04;
	
		if (minigames_alpha >= 1) {
			minigames_alpha = 1;
			state = -1;
			alarm[2] = 1;
		}
		break;
		
	case 3:
		alpha += 0.01;
		
		if (alpha >= 1) {
			send_to_minigame();
		}
		break;
}