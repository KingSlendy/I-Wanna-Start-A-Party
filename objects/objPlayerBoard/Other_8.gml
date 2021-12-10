var space = instance_place(x, y, objBoardSpaces);
var passing = false;

with (space) {
	passing = space_passing_event();
}

if (!passing) {
	global.dice_roll--;
}

if (follow_path != null && path_exists(follow_path)) {
	path_delete(follow_path);
}

if (global.dice_roll > 0) {
	board_advance();
} else {
	with (space) {
		space_finish_event();
	}
}