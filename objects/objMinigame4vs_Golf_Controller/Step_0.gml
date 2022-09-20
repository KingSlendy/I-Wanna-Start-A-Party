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