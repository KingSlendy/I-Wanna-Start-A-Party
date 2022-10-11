with (objMinigameController) {
	if (!other.is_down) {
		minigame2vs2_points(points_teams[0][0].network_id, points_teams[0][1].network_id);
	} else {
		minigame2vs2_points(minigame1vs3_solo().network_id, points_teams[1][1].network_id);
	}
	
	minigame_finish();
}