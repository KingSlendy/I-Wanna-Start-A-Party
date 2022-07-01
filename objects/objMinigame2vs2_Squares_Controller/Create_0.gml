with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 40;
action_end = function() {
	alarm[4] = 0;
	alarm[5] = 0;
	
	var player = focus_player_by_id(global.player_id);
	
	if (minigame2vs2_get_points(player.network_id, player.teammate.network_id) >= 22) {
		gain_trophy(29);
	}
}

points_draw = true;
player_check = objPlayerStatic;
