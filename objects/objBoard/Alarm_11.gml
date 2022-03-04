if (global.board_started && global.player_id == 1) {
	var actions = ai_actions(player_info_by_turn(global.player_turn).network_id);

	if (actions != null) {
		var keys = variable_struct_get_names(actions);
		actions[$ keys[irandom(array_length(keys) - 1)]].press();
	}
}

alarm[11] = 1;