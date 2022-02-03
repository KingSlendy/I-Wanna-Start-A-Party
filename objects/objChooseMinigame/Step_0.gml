if (state == 0) {
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
	}
} else if (state == 1) {
	alpha -= 0.05;
	
	if (alpha <= 0) {
		with (objPlayerInfo) {
			//Temp
			if (array_contains([1, 2], player_info.network_id)) {
				player_info.space = c_blue;
			} else {
				player_info.space = c_red;
			}
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
}