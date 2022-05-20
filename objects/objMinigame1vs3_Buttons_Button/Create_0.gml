function press_button(player_id) {
	if (image_index == 1) {
		image_index = 0;
		
		if (inside) {
			objMinigameController.alarm[4] = get_frames(0.6);
		} else {
			objMinigameController.alarm[5] = get_frames(0.4);
		}
		
		minigame_4vs_points(objMinigameController.info, player_id - 1, 1);
	}
}
