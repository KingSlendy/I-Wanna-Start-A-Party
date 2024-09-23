event_inherited();

if (solo_action != null) {
	var player = minigame1vs3_solo();
	var action_x = player.x - 128;
	
	for (var i = 0; i < solo_action_total; i++) {
		var color = c_white;
	
		if ((solo_correct && solo_advance == i) || solo_advance > i) {
			color = c_lime;
		} else if (solo_wrong && solo_advance == i) {
			color = c_red;
		}
		
		var length = array_length(solo_actions);
		var current_solo_advance = (solo_current - solo_advance + length) % length;
		var current_solo_action = solo_actions[(current_solo_advance + i + length) % length];
		var current_solo_action_bind = global.actions[$ current_solo_action].bind();
		var current_solo_action_xoffset = abs(sprite_get_xoffset(current_solo_action_bind) - sprite_get_xoffset(sprKey_Blank));
	
		draw_sprite_ext(current_solo_action_bind, 0, action_x + current_solo_action_xoffset, player.y + 64, 1, 1, 0, color, 1);
		action_x += sprite_get_width(current_solo_action_bind) + 16;
	}
}

if (team_action != null) {
	var player = minigame1vs3_team(team_turn);
	var color = c_white;
	
	if (team_correct) {
		color = c_lime;
	} else if (team_wrong) {
		color = c_red;
	}
	
	draw_sprite_ext(global.actions[$ team_action].bind(), 0, player.x, player.y - 64, 1, 1, 0, color, 1);
}
