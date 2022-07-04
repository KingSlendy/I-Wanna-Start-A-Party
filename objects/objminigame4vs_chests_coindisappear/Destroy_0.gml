if (instance_number(object_index) <= 1) {
	with (objMinigame4vs_Chests_Chest) {
		image_index = 0;
		target_spd += 7;
		selectable = false;
		selected = -1;
	}
	
	objMinigameController.alarm[1] = get_frames(1);
}