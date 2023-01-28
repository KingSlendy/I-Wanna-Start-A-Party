if (!sledge_start || info.is_finished) {
	exit;
}

for (var i = 1; i <= global.player_max; i++) {
	var player = focus_player_by_turn(i);
	
	with (player.sledge) {
		if (stopped) {
			break;
		}
		
		if (global.actions.shoot.pressed(player.network_id)) {
			sledge_shoot();
		}
	
		if (global.actions.jump.pressed(player.network_id)) {
			sledge_jump();
		}
	}
}