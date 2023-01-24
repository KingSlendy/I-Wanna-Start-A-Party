function press_button(player_id) {
	if (image_index == 1) {
		image_index = 0;
		
		with (objMinigameController) {
			alarm_call(4 + !other.inside, 0.5);
			
			if (trial_is_title(CHALLENGE_MEDLEY)) {
				minigame_time += 2;
			}
		}
		
		minigame4vs_points(player_id, 1);
		
		if (trial_is_title(CHALLENGE_MEDLEY) && minigame2vs2_get_points_team(0) + minigame2vs2_get_points_team(1) == 25) {
			minigame4vs_set_points(1);
			minigame_finish();
		}
	}
}