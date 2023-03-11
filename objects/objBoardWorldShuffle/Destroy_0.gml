if (is_player_turn()) {
	board_advance();
} else {
	global.dice_roll = 0;
	turn_next(false);
}