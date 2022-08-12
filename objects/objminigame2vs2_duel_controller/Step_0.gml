if (revive == 0) {
	alpha += 0.02;
	
	if (alpha >= 1) {
		alpha = 1;
		revive = 1;
		objPlayerBase.lost = false;
	}
} else if (revive == 1) {
	alpha -= 0.02;
	
	if (alpha <= 0) {
		alpha = 0;
		revive = -1;
		alarm[1] = get_frames(1.5);
	}
}

if (info.is_finished) {
	exit;
}

if (take_time) {
	for (var i = 0; i < global.player_max; i++) {
		if (is_player_local(i + 1) && player_can_shoot[i]) {
			player_shot_time[i]++;
		}
	}
}