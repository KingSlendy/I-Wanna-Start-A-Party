if (info.is_finished) {
	exit;
}

if (revive == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		revive = 1;
		objPlayerBase.lost = false;
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
	for (var i = 0; i < global.player_max; i++) {
		if (is_player_local(i + 1) && player_can_shoot[i]) {
			player_shot_time[i]++;
		}
	}
}

if (minigame_lost_all(true)) {
	achieve_trophy(65);
}