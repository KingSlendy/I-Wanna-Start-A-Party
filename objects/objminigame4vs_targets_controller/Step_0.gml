if (info.is_finished) {
	exit;
}

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

if (next_turn != -1) {
	exit;
}

if (!instance_exists(objBullet) && player_bullets[player_turn - 1] == 0) {
	end_turn();
}