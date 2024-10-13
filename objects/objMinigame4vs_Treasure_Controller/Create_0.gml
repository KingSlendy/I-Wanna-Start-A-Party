event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		jump_total = -1;
		jump_time = 0;
		shoot_time = 0;
		move_delay_timer = 0;
		jump_delay_timer = 0;
	}
}

player_type = objPlayerPlatformer;

trophy_obtain = true;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (!objMinigame4vs_Treasure_Treasure.visible) {
				if (--jump_time <= 0) {
					jump_time = irandom_range(10, 45);
					actions.jump.hold(jump_time - 5);
				}
			
				if (--shoot_time <= 0) {
					var action = choose(actions.left, actions.right);
					action.press();
					shoot_time = irandom_range(20, 50);
				}
			
				if (chance(0.4)) {
					actions.shoot.press();
				}
			} else {
				var near_x = objMinigame4vs_Treasure_Treasure.x + 16;
				var near_y = objMinigame4vs_Treasure_Treasure.y + 16;
			
				mp_grid_path(other.grid, path, x, y, near_x, near_y, true);
			
				if (move_delay_timer > 0) {
					move_delay_timer--;
					break;
				}
			
				if (move_delay_timer == 0 && on_block && 0.01 > random(1)) {
					move_delay_timer = irandom_range(get_frames(0.75), get_frames(1.25));
					break;
				}
			
				if (point_distance(x, y, near_x, near_y) < 2) {
					break;
				}
			
				var dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
				if (abs(angle_difference(dir, 270)) >= 16) {
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
	}

	alarm_frames(11, 1);
});