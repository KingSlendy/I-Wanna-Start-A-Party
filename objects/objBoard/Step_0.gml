if (fade_start && get_player_count(objPlayerBoard) == global.player_max) {
	fade_alpha -= 0.03;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		fade_start = false;
		
		if (global.player_id == 1) {
			board_start();
		}
	}
}

if (!tell_choices && !global.board_started && is_local_turn() && instance_number(objDiceRoll) == global.player_max) {
	tell_turns();
	tell_choices = true;
}