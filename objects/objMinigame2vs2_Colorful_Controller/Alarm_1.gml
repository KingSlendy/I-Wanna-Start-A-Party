with (objMinigame2vs2_Colorful_Patterns) {
	if (x < 400) {
		var player = objMinigameController.points_teams[0][0];
		pattern_player_ids = [player.network_id, player.teammate.network_id];
	}
}

with (objMinigame2vs2_Colorful_Patterns) {
	if (x > 400) {
		var player = objMinigameController.points_teams[1][0];
		pattern_player_ids = [player.network_id, player.teammate.network_id];
	}
}
