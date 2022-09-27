event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		has_item = false;
		jump_total = -1;
	}
}

minigame_camera = CameraMode.Split4;
player_type = objPlayerPlatformer;
distance_to_win = 16;

alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.4;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
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
		
		with (player) {
			if (move_delay_timer > 0) {
				move_delay_timer--;
				break;
			}
			
			if (move_delay_timer == 0 && on_block && 0.01 > random(1)) {
				move_delay_timer = irandom_range(get_frames(0.75), get_frames(1.25));
				break;
			}
			
			var me_x = x - 1;
			var me_y = y - 7;
			var other_x = near.x;
			var other_y = near.y;
			
			if (point_distance(me_x, me_y, other_x, other_y) < other.distance_to_win) {
				break;
			}
			
			mp_grid_path(other.grid, path, me_x, me_y, other_x, other_y, true);
			var dir = point_direction(me_x, me_y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			if (point_distance(0, dir, 0, 270) >= 16) {
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (--jump_delay_timer <= 0 && dist_to_up < 45 && vspeed >= 0) {
					actions.jump.hold(6);
					jump_delay_timer = 12;
				}
			}
		}
	}

	alarm_frames(11, 1);
});