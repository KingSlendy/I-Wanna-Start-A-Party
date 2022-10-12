event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		chosen_player = null;
		chosen_offset = 0;
		chosen_action = null;
		general_delay = 0;
	}
}

minigame_time = 30;
minigame_time_end = function() {
	if (minigame1vs3_lost()) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;

input_start = false;
shoot_delay = 0;
trophy_saver = true;

function create_laser(x, y) {
	instance_create_layer(x + 16, y + 16, "Actors", objMinigame1vs3_Aiming_Laser);
}

alarm_override(1, function() {
	with (objPlayerBase) {
		if (network_id == minigame1vs3_solo().network_id) {
			frozen = false;
			break;
		}
	}
	
	input_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				if (--general_delay <= 0 || chosen_player == null) {
					var num = irandom(minigame1vs3_team_length() - 1);
					
					with (objMinigame1vs3_Aiming_Block) {
						if (is_player && player_num == num) {
							other.chosen_player = id;
							break;
						}
					}
					
					chosen_offset = irandom_range(-16, 16);
					general_delay = get_frames(random_range(1, 3));
				}
				
				if (!instance_exists(chosen_player)) {
					chosen_player = null;
					break;
				}
				
				var dist = point_distance(x, y, chosen_player.x + 16 + chosen_offset, y);
				
				if (dist <= 3) {
					actions.shoot.press();
					break;
				}
				
				var dir = point_direction(x, y, chosen_player.x + 16 + chosen_offset, y);
				var action = (dir == 0) ? actions.right : actions.left;
				action.press();
			} else {
				if (lost) {
					break;
				}
				
				if (--general_delay <= 0) {
					chosen_action = choose("left", "right");
					general_delay = get_frames(random_range(1, 3));
				}
				
				var block = null;
				
				with (objMinigame1vs3_Aiming_Block) {
					if (is_player && minigame1vs3_team(player_num).network_id == i) {
						block = id;
						break;
					}
				}
				
				var laser = collision_rectangle(block.bbox_left, block.bbox_top, block.bbox_right, block.bbox_bottom + 112, objMinigame1vs3_Aiming_Laser, true, true);
				
				if (laser != noone) {
					if ((laser.x > x + 16 && !place_meeting(x - 6, y, objMinigame1vs3_Aiming_Block)) || place_meeting(x + 6, y, objMinigame1vs3_Aiming_Block)) {
						actions.left.press();
					} else {
						actions.right.press();
					}
				
					break;
				}
				
				laser = instance_nearest(x, y, objMinigame1vs3_Aiming_Laser);
				
				if (laser != noone && laser.bbox_bottom >= block.bbox_top - 8) {
					break;
				}
				
				actions[$ chosen_action].press();
			}
		}
	}

	alarm_frames(11, 1);
});