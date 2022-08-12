for (var i = 1; i <= global.player_max; i++) {
	if (focus_player_by_id(i).lost) {
		player_shot_time[i - 1] = get_frames(999);
	} else if (i == global.player_id) {
		trophy_obtain = false;
	}
}

take_time = false;

while (array_count(player_shot_time, 0) > 0) {
	alarm[5] = 1;
	exit;
}

var rival_times = [
	player_shot_time[points_teams[0][0].network_id - 1] - player_shot_time[points_teams[1][0].network_id - 1],
	player_shot_time[points_teams[0][1].network_id - 1] - player_shot_time[points_teams[1][1].network_id - 1]
];

for (var i = 0; i < 2; i++) {
	var time = rival_times[i];
	
	if (time == 0) {
		for (var j = 0; j < 2; j++) {
			with (points_teams[j][i]) {
				player_kill();
			}
		}
	} else {
		with (points_teams[(time < 0)][i]) {
			player_kill();
		}
		
		with (points_teams[(time > 0)][i]) {
			minigame4vs_points(network_id, 1);
		}
	}
}

alarm[6] = get_frames(1);