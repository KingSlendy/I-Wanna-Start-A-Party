if (!is_player_local(focus_player_by_turn(player_turn).network_id)) {
	exit;
}

with (objMinigameController) {
	minigame4vs_points(other.player_turn);
	minigame_finish(true);
}