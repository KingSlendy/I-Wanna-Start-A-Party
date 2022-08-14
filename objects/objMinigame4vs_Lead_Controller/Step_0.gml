if (allowed) {
	if (stopped) {
		exit;
	}
	
	var player = focus_player_by_turn(other.minigame_turn);
	
	for (var i = 0; i < array_length(sequence_actions); i++) {
		if (global.actions[$ sequence_actions[i]].pressed(player.network_id)) {
			check_input(i);
			break;
		}
	}
}