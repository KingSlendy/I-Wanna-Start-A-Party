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
				if (!instance_exists(objMinigame1vs3_Avoid_Cherry)) {
					break;
				}
				
				var intersect = function(x1, y1, x2, y2, x3, y3, x4, y4) {
					var check = function(x1, y1, x2, y2, x3, y3) {
						return ((y3 - y1) * (x2 - x1) > (y2 - y1) * (x3 - x1));
					}
					
				    return (check(x1, y1, x3, y3, x4, y4) != check(x2, y2, x3, y3, x4, y4) && check(x1, y1, x2, y2, x3, y3) != check(x1, y1, x2, y2, x4, y4));
				}
				
				var dirs = [];
				
				for (var j = 0; j < 180; j += 180 / 8) {
					var intersection = false;
					var x1 = x;
					var y1 = y;
					var x2 = x + lengthdir_x(12, j);
					var y2 = y + lengthdir_y(12, j);
					
					with (objMinigame1vs3_Avoid_Cherry) {
						var x3 = x;
						var y3 = y;
						var x4 = x3;
						var y4 = y3;
						
						x4 += hspeed * 10;
						var tvspd = vspeed;
						
						repeat (10) {
							y4 += tvspd;
							tvspd += gravity;
						}
						
						if (intersect(x1, y1, x2, y2, x3, y3, x4, y4)) {
							intersection = true;
							break;
						}
					}
					
					if (!intersection) {
						array_push(dirs, j);
					}
				}
				
				if (array_length(dirs) == 0) {
					continue;
				}
				
				array_shuffle(dirs);
				var dir = array_pop(dirs);
				var dist_to_up = abs(angle_difference(dir, 90));
				
				if (dist_to_up > 4) {
					var action = (dir >= 90 && dir <= 270) ? actions.left : actions.right;
					action.press();
				}
		
				if (vspd >= 0 && dist_to_up < 45) {
					actions.jump.hold(irandom_range(10, 21));
				}
			}
		}
	}

	alarm_frames(11, 1);
});