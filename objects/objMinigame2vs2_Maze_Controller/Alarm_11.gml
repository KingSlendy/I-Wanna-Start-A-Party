if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = ai_actions(i);

	if (actions != null) {
		var player = focus_player_by_id(i);
		var player_info = player_info_by_id(i);
		var near;
		
		if (!player.has_item) {
			with (objMinigame2vs2_Maze_Item) {
				if (image_blend != player_info.space) {
					instance_deactivate_object(id);
				}
			}
	
			near = instance_nearest(player.x, player.y, objMinigame2vs2_Maze_Item);
			instance_activate_object(objMinigame2vs2_Maze_Item);
		} else {
			near = player.teammate;
		}
		
		var dir = null;
		
		with (player) {
			if (move_delay_timer > 0) {
				move_delay_timer--;
				break;
			}
			
			if (move_delay_timer == 0 && on_block && 0.01 > random(1)) {
				move_delay_timer = irandom_range(get_frames(1.5), get_frames(2.5));
				break;
			}
			
			if (point_distance(x, y, near.x, near.y) < other.distance_to_win) {
				break;
			}
			
			mp_grid_path(other.grid, path, x - 1, y - 7, near.x, near.y, false);
			dir = point_direction(x - 1, y - 7, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			if (point_distance(0, dir, 0, 270) >= 16) {
				var dist_to_up = point_distance(0, dir, 0, 90);
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (--jump_delay_timer <= 0 && dist_to_up < 16) {
					actions.jump.hold(6);
					jump_delay_timer = 10;
				}
			}
		}
	}
}

alarm[11] = 1;