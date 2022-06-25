function press_button(player_id) {
	if (image_index == 1) {
		image_index = 0;
		
		if (inside) {
			objMinigameController.alarm[4] = get_frames(0.5);
		} else {
			objMinigameController.alarm[5] = get_frames(0.4);
		}
		
		minigame4vs_points(player_id, 1);
	}
}
