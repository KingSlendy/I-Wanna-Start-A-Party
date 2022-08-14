if (instance_number(object_index) <= 1) {
	with (objMinigame4vs_Chests_Chest) {
		image_index = 0;
		target_spd += 7;
		selectable = false;
		selected = -1;
	}
	
	with (objMinigameController) {
		alarm_call(1, 1);
	}
}