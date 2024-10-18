event_inherited();

minigame_players = function() {
	objPlayerBase.enable_shoot = false;
	
	with (objPlayerBase) {
		enable_shoot = false;
		near_platform = null;
	}
}

minigame_time = 30;
action_end = function() {
	var white_count = 0;
	
	with (objMinigame4vs_Painting_Platform) {
		if (image_blend == c_white) {
			white_count++;
		}
	}
	
	if (white_count == 1) {
		achieve_trophy(92);
	}
}

points_draw = true;
player_type = objPlayerPlatformer;

if (trial_is_title(RANDRANDRAND_TIME)) {
	instance_destroy(objMinigame4vs_Painting_Platform);
	
	repeat (irandom_range(30, 50)) {
		var rand_x = irandom_range(32, 800 - 48);
		var rand_y = irandom_range(32, 608 - 64);
		instance_create_layer(rand_x, rand_y, "Collisions", objMinigame4vs_Painting_Platform);
	}
}

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (place_meeting(x, y + 1, objBlock) || (near_platform != null && (near_platform.player_id == network_id || distance_to_object(near_platform) > 96))) {
				near_platform = null;
			}
			
			var platform = instance_place(x, y, objMinigame4vs_Painting_Platform);
			
			if ((vspd >= 0 && (platform == noone || platform.player_id != network_id)) || (platform != noone && platform.player_id != network_id)) {
				var frames = 15;
				
				if (near_platform != null) {
					var dist = near_platform.y + 16 - y;
					
					if (dist >= 0) {
						frames = 2;
					} else if (dist < 0) {
						frames = 21;
					}
				}
				
				actions.jump.hold(frames);
				
				if (platform != noone && platform.player_id != network_id) {
					near_platform = null;
				}
			}
			
			if (near_platform == null) {
				var priority = ds_priority_create();
				
				with (objMinigame4vs_Painting_Platform) {
					if (player_id == other.network_id) {
						continue;
					}
					
					ds_priority_add(priority, id, point_distance(x + 8, y, other.x, other.y));
				}
				
				var choices = [];
			
				repeat (6) {
					array_push(choices, ds_priority_delete_min(priority));
				}
			
				array_shuffle_ext(choices);
				var max_points = minigame4vs_get_max_points();
			
				if (max_points >= ceil(instance_number(objMinigame4vs_Painting_Platform) / global.player_max)) {
					for (var j = 0; j < 4; j++) {
						var choice = choices[j];
					
						if (choice.player_id != 0 && minigame4vs_get_points(choice.player_id) == max_points) {
							near_platform = choice;
							break;
						}
					}
				}
				
				if (near_platform == null) {
					near_platform = array_pop(choices);
				}
				
				ds_priority_destroy(priority);
			}
			
			if (point_distance(x, 0, near_platform.x + 8, 0) > 3) {
				var action = (x < near_platform.x + 8) ? actions.right : actions.left;
				action.press();
			}
		}
	}

	alarm_frames(11, 1);
});