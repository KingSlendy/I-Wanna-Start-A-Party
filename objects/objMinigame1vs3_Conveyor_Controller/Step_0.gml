if (info.is_finished) {
	exit;
}

var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count == global.player_max - 1) {
	with (objPlayerBase) {
		if (y < 288) {
			minigame_4vs_points(objMinigameController.info, network_id);
			break;
		}
	}
	
	minigame_finish(true);
}
