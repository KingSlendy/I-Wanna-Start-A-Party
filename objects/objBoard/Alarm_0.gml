var actions = ai_actions(global.player_turn);

if (actions != null) {
	var keys = variable_struct_get_names(actions);
	actions[$ keys[irandom(array_length(keys) - 1)]].press();
}

alarm[0] = 1;