var player_id = focus_player_by_turn(player_turn).network_id;

if (!is_player_local(player_id)) {
	exit;
}

with (objMinigameController) {
	alarm_next(8);
}