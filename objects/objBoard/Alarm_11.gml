alarm[11] = 2;

if (global.player_id != 1) {
	exit;
}

if (global.board_started) {
	var actions = check_player_actions_by_id(player_info_by_turn(global.player_turn).network_id);

	if (actions == null) {
		exit;
	}

	var action = null;
	
	if (instance_exists(objPathChange)) {
		var action = actions.jump;
	}

	if (action == null) {
		var keys = variable_struct_get_names(actions);
		var action = actions[$ keys[irandom(array_length(keys) - 1)]];
	}
	
	action.press();
} else {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);
		
		if (actions == null) {
			continue;
		}
		
		actions.jump.press();
	}
}