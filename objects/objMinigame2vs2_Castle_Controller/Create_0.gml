event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		follow_spike = null;
	}
}

minigame_time = 45;
points_draw = true;

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	next_seed_inline();
	
	with (objMinigame2vs2_Castle_Spike) {
		speed = irandom_range(1, 4);
		direction = irandom_range(200, 339);
	}
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			if (follow_spike == null || !instance_exists(follow_spike)) {
				var space = player_info_by_id(network_id).space;
			
				with (objMinigame2vs2_Castle_Spike) {
					if (self.image_blend != space || distance_to_object(other) > 64) {
						instance_deactivate_object(id);
					}
				}
				
				while (true) {
					if (!instance_exists(objMinigame2vs2_Castle_Spike)) {
						follow_spike = null;
						break;
					}
					
					var spike = instance_nearest(x, y, objMinigame2vs2_Castle_Spike);
					var me_dist = distance_to_object(spike);
					var teammate_dist = infinity;
				
					with (teammate) {
						teammate_dist = distance_to_object(spike);
					}
					
					if (me_dist < teammate_dist) {
						follow_spike = spike;
						break;
					}
					
					instance_deactivate_object(spike);
				}
			
				instance_activate_object(objMinigame2vs2_Castle_Spike);
			}
			
			if (follow_spike == null) {
				break;
			}
			
			var dist = point_distance(x, y, follow_spike.x + 16, follow_spike.y + 16);
			
			if (dist <= 3) {
				actions.shoot.press();
				break;
			}
			
			var dir = point_direction(x, y, follow_spike.x + 16, follow_spike.y + 16);
			
			if (point_distance(180, 0, dir, 0) <= 10) {
				actions.left.press();
				actions.shoot.press();
			}
			
			if (point_distance(0, 0, dir, 0) <= 10) {
				actions.right.press();
				actions.shoot.press();
			}
			
			if (abs(angle_difference(dir, 270)) >= 16) {
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir > 90 && dir < 270) ? actions.left : actions.right;
					action.hold(irandom_range(5, 8));
				}
		
				if (vspd >= 0 && dist_to_up < 30) {
					actions.jump.hold(irandom_range(3, 10));
				}
			}
		}
	}

	alarm_frames(11, 1);
});