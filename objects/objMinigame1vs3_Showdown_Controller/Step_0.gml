if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	with (objPlayerBase) {
		if (y < 272) {
			if (network_id == global.player_id && other.rounds == 0) {
				gain_trophy(13);
			}
			
			minigame4vs_points(network_id);
			break;
		}
	}
	
	minigame_finish(true);
}