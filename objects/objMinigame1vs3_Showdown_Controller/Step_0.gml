if (info.is_finished) {
	exit;
}

if (minigame1vs3_lost()) {
	with (points_teams[1][0]) {
		if (network_id == global.player_id && other.rounds == 0) {
			minigame4vs_points(network_id);	
		}
	}
	
	minigame_finish();
}