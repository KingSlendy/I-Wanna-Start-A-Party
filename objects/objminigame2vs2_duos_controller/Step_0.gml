if (info.is_finished) {
	exit;
}

if (points_teams[0][0].finished && points_teams[0][1].finished) {
	minigame2vs2_points(points_teams[0][0].network_id, points_teams[0][1].network_id);
	minigame_finish(true);
}

if (minigame1vs3_solo().finished && points_teams[1][1].finished) {
	minigame2vs2_points(minigame1vs3_solo().network_id, points_teams[1][1].network_id);
	minigame_finish(true);
}