event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		door = null;
		fade = -1;
		entered = [];
		target = null;
	}
}

minigame_camera = CameraMode.Split4;
player_type = objPlayerPlatformer;

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
				break;
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
					with (objMinigame4vs_Mansion_Door) {
						if (y < 288) {
							array_push(choices, id);
							break;
						}
					}
				}
	
				array_shuffle(choices);
				target = array_pop(choices);
			}
			
			var door = instance_place(x, y, target);
			
			if (door != noone) {
				target = null;
				actions.up.press();
				array_push(entered, door.id, door.link.id);
				continue;
			}

			var dir = point_direction(x, y, target.x + 64, y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.press();
		}
	}
	
	alarm_frames(11, 1);
});