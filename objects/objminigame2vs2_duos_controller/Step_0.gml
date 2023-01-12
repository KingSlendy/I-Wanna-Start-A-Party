if (info.is_finished) {
	exit;
}

if (points_teams[0][0].finished && points_teams[0][1].finished) {
	minigame2vs2_points(points_teams[0][0].network_id, points_teams[0][1].network_id);
	minigame_finish(true);
}

if (points_teams[1][0].finished && points_teams[1][1].finished) {
	minigame2vs2_points(points_teams[1][0].network_id, points_teams[1][1].network_id);
	minigame_finish(true);
}