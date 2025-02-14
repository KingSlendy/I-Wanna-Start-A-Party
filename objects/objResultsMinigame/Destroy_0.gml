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
	
	if (chance(global.board_dark_chance)) {
		instance_create_layer(0, 0, "Managers", objBoardHyruleWorldTransition);
		
		if (global.board_light) {
			global.board_dark_chance = 0;
		} else {
			global.board_dark_chance = 0.5;
		}
		
		exit;
	}
	
	global.board_dark_chance += 0.2;
}

board_start();