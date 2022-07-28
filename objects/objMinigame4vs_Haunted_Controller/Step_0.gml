if (info.is_finished) {
	exit;
}

if (minigame_lost_all(true)) {
	with (objPlayerBase) {
		minigame4vs_points(network_id, -1);
	}
	
	minigame_finish(true);
}