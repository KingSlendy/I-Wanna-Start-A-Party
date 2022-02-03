for (var i = 1; i <= global.player_max; i++) {
	var actions = ai_actions(i);

	if (actions != null) {
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

alarm[0] = 1;