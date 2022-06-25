event_inherited();

if (solo_action != null) {
	var player = points_teams[1][0];
	var color = c_white;
	
	if (solo_correct) {
		color = c_lime;
	} else if (solo_wrong) {
		color = c_red;
	}
	
	draw_sprite_ext(bind_to_key(global.actions[$ solo_action].button), 0, player.x, player.y + 64, 1, 1, 0, color, 1);
}

if (team_action != null) {
	var player = points_teams[0][team_turn];
	var color = c_white;
	
	if (team_correct) {
		color = c_lime;
	} else if (team_wrong) {
		color = c_red;
	}
	
	draw_sprite_ext(bind_to_key(global.actions[$ team_action].button), 0, player.x, player.y - 64, 1, 1, 0, color, 1);
}
