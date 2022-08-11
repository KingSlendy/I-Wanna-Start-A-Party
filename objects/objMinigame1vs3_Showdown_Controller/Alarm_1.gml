if (minigame1vs3_lost()) {
	with (points_teams[1][0]) {
		if (network_id == global.player_id && other.rounds == 0) {
			gain_trophy(13);
		}
		
		minigame4vs_points(network_id);	
	}
	
	minigame_finish();
	exit;
}

if (++rounds == instance_number(objMinigame1vs3_Showdown_Rounds)) {
	var survived = true;
	var below = false;
	
	for (var i = 0; i < array_length(points_teams[0]); i++) {
		with (points_teams[0][i]) {
			if (lost) {
				survived = false;
			}
			
			if (network_id == global.player_id) {
				below = true;
			}
			
			minigame4vs_points(network_id);
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