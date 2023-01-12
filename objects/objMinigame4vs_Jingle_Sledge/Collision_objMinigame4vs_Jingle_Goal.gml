if (!is_player_local(player_id)) {
	exit;
}

with (objMinigameController) {
	minigame4vs_points(other.player_id);
	minigame_finish(true);
}