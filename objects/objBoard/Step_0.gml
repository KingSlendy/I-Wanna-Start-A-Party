if (!tell_choices && !global.board_started && is_local_turn() && instance_number(objDiceRoll) == global.player_max) {
	tell_turns();
	tell_choices = true;
}