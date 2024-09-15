event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		has_item = false;
		jump_total = -1;
		move_delay_timer = 0;
		jump_delay_timer = 0;
	}
}

if (trial_is_title(CHALLENGE_MEDLEY)) {
	minigame_time = 60;
	minigame_time_valign = fa_top;
}

minigame_camera = CameraMode.Split4;
player_type = objPlayerPlatformer;
distance_to_win = 16;

alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.4;
});

alarm_override(11, function() {
	if (trial_is_title(CHALLENGE_MEDLEY)) {
		return;
	}
	
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		var player_info = player_info_by_id(i);
		
		with (player) {
			var near;
			var near_x = 0;
			var near_y = 0;
		
			if (!has_item) {
				with (objMinigame2vs2_Maze_Item) {
					if (image_blend != player_info.space) {
						instance_deactivate_object(id);
					}
				}
	
				near = instance_nearest(x, y, objMinigame2vs2_Maze_Item);
				near_x = near.x + 16;
				near_y = near.y + 16;
				instance_activate_object(objMinigame2vs2_Maze_Item);
			} else {
				near = teammate;
				near_x = near.x;
				near_y = near.y;
			}
			
			mp_grid_path(other.grid, path, x, y, near_x, near_y, true);
			
			if (move_delay_timer > 0) {
				move_delay_timer--;
				break;
			}
			
			if (move_delay_timer == 0 && on_block && 0.01 > random(1)) {
				move_delay_timer = irandom_range(get_frames(0.75), get_frames(1.25));
				break;
			}
			
			if (point_distance(x, y, near_x, near_y) < other.distance_to_win) {
				break;
			}
			
			var dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			if (abs(angle_difference(dir, 270)) >= 16) {
				//if (!on_block) {
				//	for (var j = 0; j < path_get_number(path) - 1; j++) {
				//		var now_x = floor(path_get_point_x(path, j) / 32) * 32 + 16;
				//		var now_y = floor(path_get_point_y(path, j) / 32) * 32 + 16;
				//		var test_x = floor(path_get_point_x(path, j + 1) / 32) * 32 + 16;
				//		var test_y = floor(path_get_point_y(path, j + 1) / 32) * 32 + 16;
				//		var test_dir = point_direction(now_x, now_y, test_x, test_y);
					
				//		if (test_dir == 0 || test_dir == 180) {
				//			var action = (test_dir == 0) ? actions.right : actions.left;
				//			action.press();
				//			break;
				//		}
				//	}
				//}
				
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (--jump_delay_timer <= 0 && dist_to_up < 45) {
					actions.jump.hold(6);
					jump_delay_timer = 12;
				}
			}
		}
	}

	alarm_frames(11, 1);
});