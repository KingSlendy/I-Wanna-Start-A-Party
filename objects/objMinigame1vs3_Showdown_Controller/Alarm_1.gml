if (++rounds == instance_number(objMinigame1vs3_Showdown_Rounds)) {
	var survived = true;
	var below = false;
	
	with (objPlayerBase) {
		if (y > 272) {
			if (lost) {
				survived = false;
			}
			
			if (network_id == global.player_id) {
				below = true;
			}
			
			minigame4vs_points(objMinigameController.info, network_id);
		}
	}
	
	if (survived && below) {
		gain_trophy(12);
	}
	
	minigame_finish();
	exit;
}

with (objMinigame1vs3_Showdown_Block) {
	number = -1;
	
	if (is_player_local(player_id)) {
		selecting = true;
	}
}

minigame_time = 6;
alarm[10] = get_frames(1);
