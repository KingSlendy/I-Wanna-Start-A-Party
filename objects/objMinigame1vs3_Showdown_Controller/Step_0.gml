if (info.is_finished) {
	exit;
}

var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count == global.player_max - 1) {
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
