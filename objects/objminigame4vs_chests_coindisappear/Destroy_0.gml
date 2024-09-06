if (instance_number(object_index) <= 1) {
	var end_trial = true;
	
	with (objMinigame4vs_Chests_Chest) {
		image_index = 0;
		target_spd += 5;
		selectable = false;
		
		if (trial_is_title(STINGY_CHESTS)) {
			if (selected == global.player_id) {
				end_trial = false;
			
				if (coins == 0) {
					end_trial = true;
				}
			}
		}
		
		selected = -1;
	}
	
	if (trial_is_title(STINGY_CHESTS) && end_trial) {
		minigame4vs_set_points(global.player_id, 0);
		minigame_finish();
		return;
	}
	
	with (objMinigameController) {
		alarm_call(1, 1);
	}
}