if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	var action = actions[$ sequence_actions[irandom(array_length(sequence_actions) - 1)]];
	action.press();
}

alarm[11] = get_frames(1);
