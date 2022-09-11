with (objMinigameController) {
	if (other.y < 304) {
		minigame2vs2_points(points_teams[0][0].network_id, points_teams[0][1].network_id);
	} else {
		minigame2vs2_points(points_teams[1][0].network_id, points_teams[1][1].network_id);
	}
	
	minigame_finish();
}