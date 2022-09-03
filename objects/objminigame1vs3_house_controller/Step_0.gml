if (!house_start || info.is_finished) {
	exit;
}

if (points_teams[1][0].lost) {
	minigame_time_end();
	exit;
}

var move = (global.actions.right.held(points_teams[0][1].network_id) - global.actions.left.held(points_teams[0][0].network_id));

if (move != 0) {
	cherry_move(move);
}

if (global.actions.jump.pressed(points_teams[0][2].network_id)) {
	cherry_jump();
}