if (instance_number(object_index) <= 1) {
	with (objMinigame4vs_Chests_Chest) {
		image_index = 0;
		switch_target(, target_y - 300);
	}
	
	with (objMinigameController) {
		alarm_frames(4, 1);
		alarm_call(5, 5);
	}
}