if (next_turn == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		next_turn = 1;
		player_turn++;
		reposition_player();
	}
} else if (next_turn == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		next_turn = -1;
		unfreeze_player();
	}
}

if (next_turn != -1 || info.is_finished) {
	exit;
}

if (!instance_exists(objBullet) && player_bullets[player_turn - 1] == 0) {
	objPlayerBase.frozen = true;
	
	if (player_turn < global.player_max) {
		next_turn = 0;
	} else {
		minigame_finish();
	}

	var player = focus_player_by_turn(player_turn);

	if (player.network_id == global.player_id && minigame4vs_get_points(player.network_id) == 0) {
		gain_trophy(59);
	}
}