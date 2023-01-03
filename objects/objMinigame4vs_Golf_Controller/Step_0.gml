if (info.is_finished) {
	exit;
}

if (player_turn != 0) {
	with (focus_player_by_turn(player_turn)) {
		if ((object_index == objPlayerGolf && phy_rotation != 0) || (object_index == objNetworkPlayer && image_angle != 0)) {
			with (other) {
				alarm_stop(10);
				minigame_time = -1;
			}
		}
	}
}

if (next_turn == 0) {
	fade_alpha += 0.02 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		next_turn = 1;
		player_turn++;
	}
} else if (next_turn == 1) {
	fade_alpha -= 0.02 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		next_turn = -1;
		unfreeze_player();
	}
}