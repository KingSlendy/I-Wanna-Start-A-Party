if (fade_start && get_player_count(objPlayerBoard) == global.player_max) {
	fade_alpha -= 0.03 * DELTA;
	board_music();
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		fade_start = false;
		board_start();
	}
}

if (!global.board_started) {
	if (!tell_choices && is_local_turn() && instance_number(objDiceRoll) == global.player_max) {
		tell_turns();
		tell_choices = true;
	}
}