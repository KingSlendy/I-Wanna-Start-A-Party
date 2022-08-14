with (objBoard) {
	alarm_frames(11, 1);
}

if (!instance_exists(objLastTurns)) {
	board_start();
} else {
	with (objLastTurns) {
		alarm_frames(0, 1);
	}
}