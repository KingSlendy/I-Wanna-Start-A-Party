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
			if (point_distance(x, y, near.x, near.y) < other.distance_to_win) {
				break;
			}
			
			//path_clear_points(path);
			mp_grid_path(other.grid, path, x, y, near.x, near.y, true);
			dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			//print(path_get_number(path));
			//print(dir);
			
			if (point_distance(0, dir, 0, 270) >= 16) {
				var action;
		
				if (point_distance(0, dir, 0, 90) < 16) {
					action = actions.jump;
				} else {
					action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
				}

				action.press();
			}
		}
	}
}

alarm[11] = 1;