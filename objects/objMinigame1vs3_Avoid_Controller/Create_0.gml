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
					var blocks = [];
					
					with (objMinigame1vs3_Avoid_Block) {
						array_push(blocks, x);
					}
					
					array_shuffle_ext(blocks);
					chosed_block = array_pop(blocks) + 16;
				}
			
				if (point_distance(x, y, chosed_block, y) > 6) {
					var dir = floor(point_direction(x, y, chosed_block, y));
					var action = (dir == 0) ? actions.right : actions.left;
					action.hold(6);
				} else {
					actions.jump.hold(15);
				}
			} else {
				var cherry;
				
				if (vspd <= 0) {
					cherry = collision_rectangle(bbox_left - 30, bbox_top, bbox_right + 30, bbox_bottom, objMinigame1vs3_Avoid_Cherry, true, true);
				
					if (cherry != noone && ((cherry.x < x && cherry.hspeed > 0) || (cherry.x > x && cherry.hspeed < 0))) {
						if (cherry.hspeed > 0) {
							actions.right.hold(irandom_range(10, 20));
						} else {
							actions.left.hold(irandom_range(10, 20));
						}
						
						actions.jump.hold(irandom_range(10, 18));
						break;
					}
				} else {
					cherry = instance_place(x, y + vspd, objMinigame1vs3_Avoid_Cherry);
				
					if (cherry != noone) {
						actions.jump.hold(irandom_range(10, 18));
					}
				}
				
				cherry = collision_rectangle(bbox_left - 22, bbox_top - 128 - 64 * (vspd < 0), bbox_right + 22, bbox_bottom, objMinigame1vs3_Avoid_Cherry, true, true);
			
				if (cherry != noone) {
					if ((cherry.x >= x && !place_meeting(x - 3, y, objBlock)) || place_meeting(x + 3, y, objBlock)) {
						actions.left.press();
					} else {
						actions.right.press();
					}
				
					break;
				}
			}
		}
	}

	alarm_frames(11, 1);
});