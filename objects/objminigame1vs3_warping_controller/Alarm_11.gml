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
		if (y < 304) { 
			actions.left.press();
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

alarm[11] = 1;