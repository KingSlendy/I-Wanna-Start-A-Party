if (objMinigameController.info.is_finished || pattern_player_ids == null) {
	exit;
}

for (var i = 0; i < 2; i++) {
	var player_id = pattern_player_ids[i];
		
	if (!is_player_local(player_id)) {
		continue;
	}
		
	if (global.actions.jump.pressed(player_id)) {
		pattern_select(i);
	}
		
	if (pattern_selected[i]) {
		continue;
	}
	
	var v = (global.actions.down.pressed(player_id) - global.actions.up.pressed(player_id));
	var h = (global.actions.right.pressed(player_id) - global.actions.left.pressed(player_id));
		
	if (v != 0) {
		pattern_move_vertical(i, v);
	}
		
	if (h != 0) {
		pattern_move_horizontal(i, h);
	}
}

//Animation
for (var i = 0; i < 2; i++) {
	if (pattern_selected[i]) {
		wave_animation(i);
		continue;
	}
	
	wave_reset_animation(i);
}