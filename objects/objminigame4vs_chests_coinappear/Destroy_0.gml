if (instance_number(object_index) <= 1) {
	with (objMinigame4vs_Chests_Chest) {
		image_index = 0;
		switch_target(, target_y - 300);
	}
	
	with (objMinigameController) {
		alarm[4] = 1;
		alarm[5] = get_frames(5);
	}
}