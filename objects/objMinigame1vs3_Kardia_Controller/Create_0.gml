event_inherited();
minigame_start = minigame1vs3_start;
minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 30;
minigame_time_halign = fa_center;
minigame_time_valign = fa_middle;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;

kardia_start = false;

alarm_override(1, function() {
	minigame1vs3_solo().frozen = false;
	kardia_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
		
		var player = focus_player_by_id(i);
		
		with (player) {
			var keys = variable_struct_get_names(actions);
			var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
			switch (irandom(2)) {
				case 0:
					action.hold(irandom(21));
					break;
				
				case 1:
					action.press();
					break;
				
				case 2:
					action.release(true);
					break;
			}
		}
	}

	alarm_frames(11, 1);
});