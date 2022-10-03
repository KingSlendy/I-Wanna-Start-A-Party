if (!house_start || info.is_finished) {
	exit;
}

if (minigame1vs3_solo().lost) {
	minigame_time_end();
	exit;
}

var move = (global.actions.right.held(minigame1vs3_team(1).network_id) - global.actions.left.held(minigame1vs3_team(0).network_id));

if (move != 0) {
	cherry_move(move);
}

if (global.actions.jump.pressed(minigame1vs3_team(2).network_id)) {
	cherry_jump();
}