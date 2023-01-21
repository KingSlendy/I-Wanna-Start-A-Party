function press_button(player_id) {
	if (image_index == 1) {
		image_index = 0;
		
		with (objMinigameController) {
			alarm_call(4 + !other.inside, 0.5);
		}
		
		minigame4vs_points(player_id, 1);
	}
}