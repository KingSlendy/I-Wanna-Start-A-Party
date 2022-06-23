if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	if (current < array_length(sequence) && irandom(max(20 - array_length(sequence), 1)) != 0) {
		actions[$ sequence_actions[sequence[current]]].press();
	} else {
		actions[$ sequence_actions[irandom(array_length(sequence_actions) - 1)]].press();
	}
}

alarm[11] = get_frames(0.3);
