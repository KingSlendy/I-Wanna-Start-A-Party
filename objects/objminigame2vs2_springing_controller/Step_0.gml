if (info.is_finished) {
	exit;
}
 
if (points_teams[0][0].lost && points_teams[0][1].lost) {
	minigame2vs2_points(minigame1vs3_solo().network_id, points_teams[1][1].network_id);
	minigame_finish();
}

if (minigame1vs3_solo().lost && points_teams[1][1].lost) {
	minigame2vs2_points(points_teams[0][0].network_id, points_teams[0][1].network_id);
	minigame_finish();
}