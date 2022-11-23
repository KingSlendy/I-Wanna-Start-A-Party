event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		guess_path = -1;
	}
}

minigame_time_end = function() {
	objPlayerBase.frozen = true;
	alarm_instant(4);
}

player_type = objPlayerStatic;

next_path = -1;
state_path = -1;
camera_state = -1;
current_round = 0;
player_pos = array_create(global.player_max, 0);

trophy_luigi = true;

alarm_override(1, function() {
	alarm_call(4, 1);
});

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id) && trophy_luigi) {
		achieve_trophy(69);
	}
});

alarm_create(4, function() {
	state_path = (state_path + 2 + 1) % 2;
	
	if (state_path == 0 && (current_round == 3 || minigame_lost_all())) {
		minigame_lost_points();
		minigame_finish();
		return;
	}
	
	next_path = 0;
});

alarm_create(5, function() {
	camera_state = 0;
})

alarm_create(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player =  focus_player_by_id(i);
	
		if (player_pos[i - 1] == player.guess_path) {
			continue;
		}
	
		if (player_pos[i - 1] < player.guess_path) {
			actions.right.press();
		} else {
			actions.left.press();
		}
	}

	alarm_frames(11, 1);
});