if (info.is_finished) {
	exit;
}

if (next_path == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		next_path = 1;
		
		switch (state_path) {
			case 0:
				minigame_time = -1;
			
				with (objPlayerBase) {
					x = xstart;
					y = ystart;
					other.player_pos[network_id - 1] = player_info_by_id(network_id).turn - 1;
				}
			
				intersect_generate();
				pacman_generate();
				
			case 1:
				camera_set_view_pos(view_camera[0], 0, 0);
				break;
		}
	}
} else if (next_path == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		next_path = -1;
		
		switch (state_path) {
			case 0:
				alarm_call(5, 0.1);
				break;
				
			case 1:
				with (objMinigame4vs_Waka_PacMan) {
					start_path();
				}
				
				camera_state = 1;
				break;
		}
	}
}

switch (camera_state) {
	case 0:
		camera_set_view_pos(view_camera[0], 0, camera_get_view_y(view_camera[0]) + ((!trial_is_title(WAKA_DODGES)) ? 7 : 1));
	
		if (camera_get_view_y(view_camera[0]) >= 1216) {
			camera_set_view_pos(view_camera[0], 0, 1216);
			
			with (objPlayerBase) {
				guess_path = irandom(global.player_max - 1);
				frozen = false;
			}
			
			minigame_time = 4;
			alarm_call(10, 1);
			camera_state = -1;
		}
		break;
		
	case 1:
		var cam_h = camera_get_view_height(view_camera[0]);
		
		var far_pac = null;
		var record_y = -infinity;
		
		with (objMinigame4vs_Waka_PacMan) {
			if (y > record_y) {
				far_pac = id;
				record_y = y;
			}
		}
	
		var view_y = far_pac.y - floor(cam_h / 2);
		view_y = clamp(view_y, 0, room_height - cam_h);
		camera_set_view_pos(view_camera[0], 0, view_y);
		break;
}

with (objPlayerBase) {
	if (frozen) {
		continue;
	}
	
	var move = (global.actions.right.pressed(network_id) - global.actions.left.pressed(network_id));
	
	if (move != 0) {
		if (network_id == global.player_id) {
			other.trophy_luigi = false;
		}
		
		other.player_pos[network_id - 1] = (other.player_pos[network_id - 1] + global.player_max + move) % global.player_max;
		x = 192 + (32 * 4) * other.player_pos[network_id - 1] + 17;
	}
}