event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	with (objPlayerBase) {
		idol_hole = null;
		idol_delay = 0;
	}
}

minigame_time = 30;
points_draw = true;
player_type = objPlayerHammer;

alarm_create(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (idol_delay > 0) {
				idol_delay--;
				break;
			}
			
			if (idol_hole != null && idol_hole.hit != 0) {
				idol_hole = null;
			}
			
			if (idol_hole == null) {
				var record = infinity;
				
				with (objMinigame2vs2_Idol_Hole) {
					if (show != 0 && portion != height) {
						continue;
					}
					
					var player_has_hole = false;
					
					with (objPlayerBase) {
						if (idol_hole == other.id) {
							player_has_hole = true;
							break;
						}
					}
					
					if (player_has_hole) {
						continue;
					}
				
					var dist = point_distance(other.x, other.y, x + 64, y - 15);
				
					if (dist < record) {
						other.idol_hole = id;
						record = dist;
					}
				}
			}
			
			if (idol_hole == null) {
				break;
			}

			if (point_distance(x, y, idol_hole.x + 64, idol_hole.y - 15) <= max_spd) {
				if (idol_hole.portion == idol_hole.height) {
					actions.shoot.press();
					idol_delay = irandom_range(10, 18);
				}
				
				idol_hole = null;
				break;
			}
			
			var dir = point_direction(x, y, idol_hole.x + 64, idol_hole.y - 15);
			minigame_angle_dir8(actions, dir);
		}
	}

	alarm_frames(11, 1);
});