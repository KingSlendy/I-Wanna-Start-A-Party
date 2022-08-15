with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	door = null;
	fade = -1;
	entered = [];
	target = null;
}

event_inherited();
minigame_camera = CameraMode.Follow;
player_check = objPlayerPlatformer;

trophy_doors = true;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
	
		with (player) {
			if (frozen) {
				continue;
			}
		
			if (target == null) {
				var choices = [];
	
				with (objMinigame4vs_Mansion_Door) {
					if (array_contains(other.entered, id) || y + 87 != floor(other.y)) {
						continue;
					}
		
					array_push(choices, id);
				}
	
				if (array_length(choices) == 0) {
					if (y < 288) {
						with (objMinigame4vs_Mansion_Door) {
							if (y < 288) {
								array_push(choices, id);
								break;
							}
						}
					}
				}
	
				array_shuffle(choices);
				target = choices[0];
			} else {
				var door = instance_place(x, y, target);
			
				if (door != noone) {
					actions.up.press();
					array_push(entered, door.id, door.link.id);
					continue;
				}
			
				var me_x = x - 1;
				var me_y = y - 7;
				var dir = point_direction(me_x, me_y, target.x + 64, me_y);
				var action = (dir == 0) ? actions.right : actions.left;
				action.press();
			}
		}
	}
	
	alarm_frames(11, 1);
});