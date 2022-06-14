if (++rounds == instance_number(objMinigame1vs3_Showdown_Rounds)) {
	with (objPlayerBase) {
		if (y > 272) {
			minigame4vs_points(objMinigameController.info, network_id);
		}
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

minigame_time = 10;
alarm[10] = get_frames(1);
