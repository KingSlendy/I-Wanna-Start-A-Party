with (objBoard) {
	alarm_frames(11, 1);
}

if (instance_exists(objLastTurns)) {
	with (objLastTurns) {
		alarm_frames(0, 1);
	}
	
	exit;
}

if (room == rBoardHyrule) {
	reset_seed_inline();
	next_seed_inline();
	var max_turns = 5;
	var curr_turn = (global.board_turn - 1) % max_turns;
	
	if (curr_turn == 0 || 1 / max_turns * curr_turn * 0.5 > random(1)) {
		instance_create_layer(0, 0, "Managers", objBoardHyruleWorldTransition);
		exit;
	}
}

board_start();