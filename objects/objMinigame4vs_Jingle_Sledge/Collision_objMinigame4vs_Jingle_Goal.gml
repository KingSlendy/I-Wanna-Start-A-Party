var player_id = focus_player_by_turn(player_turn).network_id;

if (!is_player_local(player_id)) {
	exit;
}

minigame4vs_points(player_id);
minigame_finish(true);