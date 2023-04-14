if (info.is_finished) {
	exit;
}

if (revive == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		revive = 1;
		objPlayerBase.lost = false;
		minigame_time = -1;
	}
} else if (revive == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		revive = -1;
		alarm_call(1, 1.5);
	}
}

if (take_time) {
	with (objPlayerBase) {
		if (is_player_local(network_id) && other.player_can_shoot[network_id - 1]) {
			other.player_shot_time[network_id - 1]++;
		}
	}
}

with (objPlayerBase) {
	if (lost) {
		other.player_can_shoot[network_id - 1] = false;
	}
}

if (minigame_lost_all(true)) {
	achieve_trophy(65);
}