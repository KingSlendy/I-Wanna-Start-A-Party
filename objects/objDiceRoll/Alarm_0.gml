if (target_x != null) {
	objDiceRoll.follow_target_x = true;
	exit;
}

if (global.dice_roll > 0) {
	follow_x = true;
	follow_y = true;
	
	with (objDiceRoll) {
		if (by_item) {
			instance_destroy();
		}
	}
	
	roll = 0;
	board_advance();
} else {
	show_dice();
}