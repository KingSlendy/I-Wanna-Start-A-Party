if (!sledge_start || info.is_finished) {
	exit;
}

for (var i = 0; i < array_length(points_teams[0]); i++) {
	var player_front = points_teams[i][0];
	
	if (player_front.sledge.stopped) {
		continue;
	}
	
	var player_back = points_teams[i][1];
	
	if (global.actions.shoot.pressed(player_front.network_id)) {
		with (player_front.sledge) {
			sledge_shoot();
		}
	}
	
	if (global.actions.jump.pressed(player_back.network_id)) {
		with (player_front.sledge) {
			sledge_jump();
		}
	}
}