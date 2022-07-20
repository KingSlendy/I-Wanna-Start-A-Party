if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	var player = focus_player_by_id(i);
	
	with (player) {
		var action = null;
		
		if (irandom(19) != 0) {
			if (image_xscale > 1 && other.solo_action != null) {
				action = actions[$ other.solo_action];
			}
			
			if (image_xscale == 1 && other.team_action != null) {
				action = actions[$ other.team_action];
			}
		} else {
			action = actions[$ other.press_actions[irandom(array_length(other.press_actions) - 1)]];
		}
		
		if (action != null) {
			action.press();
		}
	}
}

alarm[11] = get_frames(1.7);
