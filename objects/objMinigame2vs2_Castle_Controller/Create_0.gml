event_inherited();

minigame_start = minigame2vs2_start;
points_draw = true;

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	next_seed_inline();
	
	with (objMinigame2vs2_Castle_Spike) {
		speed = irandom_range(1, 4);
		direction = irandom_range(200, 339);
	}
});

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