event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_shoot = false;
		chosed_block = -1;
	}
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_lost()) {
		minigame1vs3_points();
	} else {
		minigame4vs_points(minigame1vs3_solo().network_id);
	}
	
	minigame_finish();
}

action_end = function() {
	with (objMinigame1vs3_Avoid_Block) {
		alarm_instant(11);
	}
	
	instance_destroy(objMinigame1vs3_Avoid_Cherry);
}

player_type = objPlayerPlatformer;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				var available = true;
			
				with (objMinigame1vs3_Avoid_Block) {
					if (image_index == image_number - 1) {
						other.chosed_block = -1;
						available = false;
						break;
					}
				}
			
				if (!available) {
					continue;
				}
			
				if (chosed_block == -1) {
					//chosed_block = choose(288, 320, 352, 416, 448, 480) + 16;
					chosed_block = choose(288, 352, 416, 480) + 16;
				}
			
				if (point_distance(x, y, chosed_block, y) > 6) {
					var dir = floor(point_direction(x, y, chosed_block, y));
					var action = (dir == 0) ? actions.right : actions.left;
					action.hold(6);
				} else {
					actions.jump.hold(15);
				}
			} else {
				var keys = variable_struct_get_names(actions);
				var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
				switch (irandom(2)) {
					case 0:
						action.hold(irandom(21));
						break;
				
					case 1:
						action.press();
						break;
				
					case 2:
						action.release(true);
						break;
				}
			}
		}
	}

	alarm_frames(11, 1);
});