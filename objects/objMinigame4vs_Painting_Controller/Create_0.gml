event_inherited();

minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 30;
points_draw = true;
player_type = objPlayerPlatformer;

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			
		}
	}

	alarm_frames(11, 1);
});