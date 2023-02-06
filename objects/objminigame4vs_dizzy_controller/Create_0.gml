event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		has_item = false;
		last_touched = null;
		target_coin = null;
		dizzy_delay = 0;
	}
}

player_type = objPlayerPlatformer;
trophy_none = true;

if (trial_is_title(FOGGY_DAY)) {
	layer_set_visible("Fog_2", true);
}


alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.8;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (target_coin == null || !instance_exists(target_coin)) {
				var choices = [];
				
				with (objMinigame4vs_Dizzy_Coin) {
					if (image_blend == player_color_by_turn(player_info_by_id(i).turn)) {
						array_push(choices, id);
					}
				}
				
				array_shuffle_ext(choices);
				target_coin = array_pop(choices);
			}
			
			if (dizzy_delay > 0) {
				dizzy_delay--;
				
				if (0.1 > random(1)) {
					var dizzy_actions = ["left", "right", "jump"];
					actions[$ dizzy_actions[irandom(array_length(dizzy_actions) - 1)]].hold(irandom_range(3, 8));
				}
				
				break;
			}
			
			mp_grid_path(other.grid, path, x, y, target_coin.x + 16, target_coin.y + 16, true);
			var dir = point_direction(x, y, path_get_point_x(path, 1), path_get_point_y(path, 1));
			
			var up = (orientation == 1) ? 90 : 270;
			var down = (orientation == 1) ? 270 : 90;
			
			if (abs(angle_difference(dir, down)) >= 16) {
				var dist_to_up = abs(angle_difference(dir, up));
				
				if (on_block) {
					if (dist_to_up > 4) {
						var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
						action.press();
					}
				} else {
					for (var j = 0; j < path_get_number(path) - 1; j++) {
						var now_x = floor(path_get_point_x(path, j) / 32) * 32 + 16;
						var now_y = floor(path_get_point_y(path, j) / 32) * 32 + 16;
						var test_x = floor(path_get_point_x(path, j + 1) / 32) * 32 + 16;
						var test_y = floor(path_get_point_y(path, j + 1) / 32) * 32 + 16;
						var test_dir = point_direction(now_x, now_y, test_x, test_y);
					
						if (test_dir == 0 || test_dir == 180) {
							var action = (test_dir == 0) ? actions.right : actions.left;
							action.press();
							break;
						}
					}
				}
		
				if (dist_to_up < 45) {
					actions.jump.press();
				}
			}
		}
	}

	alarm_frames(11, 1);
});