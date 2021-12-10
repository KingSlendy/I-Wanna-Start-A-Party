if (global.board_started && speed == 0) {
	global.dice_roll = clamp(get_integer("Enter roll", 10), -10, 10);
	global.path_direction = sign(global.dice_roll);
	global.dice_roll = abs(global.dice_roll);
	board_advance();
}