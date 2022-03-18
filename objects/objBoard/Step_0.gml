if (!tell_choices && !global.board_started && is_local_turn() && instance_number(objDiceRoll) == global.player_max) {
	tell_turns();
	tell_choices = true;
}

if (from_minigame) {
	from_minigame_alpha -= 0.03;
	
	if (from_minigame_alpha <= 0) {
		from_minigame_alpha = 0;
		from_minigame = false;
	}
}