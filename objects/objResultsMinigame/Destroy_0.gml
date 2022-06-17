objBoard.alarm[11] = 1;

if (!instance_exists(objLastTurns)) {
	board_start();
} else {
	objLastTurns.alarm[0] = 1;
}
