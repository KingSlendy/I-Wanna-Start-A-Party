if (!sledge_start || info.is_finished) {
	exit;
}

for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_turn(i).sledge) {
		if (stopped) {
			break;
		}
		
		if (global.actions.shoot.pressed(player_id)) {
			sledge_shoot();
		}
	
		if (global.actions.jump.pressed(player_id)) {
			sledge_jump();
		}
	}
}