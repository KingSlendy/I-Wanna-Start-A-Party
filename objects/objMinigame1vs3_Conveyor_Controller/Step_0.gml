if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	with (objPlayerBase) {
		if (y < 288) {
			minigame4vs_points(network_id);
			break;
		}
	}
	
	minigame_finish(true);
}
