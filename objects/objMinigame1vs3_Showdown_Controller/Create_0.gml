event_inherited();

minigame_start = minigame1vs3_start;
minigame_time_end = function() {
	minigame_time = -1;
	
	with (objMinigame1vs3_Showdown_Block) {
		if (selecting) {
			if (number == -1) {
				number = show;
			}
			
			selecting = false;
		}
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		if (is_player_local(i) && !focus_player_by_id(i).lost) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame1vs3_Showdown_Block);
			buffer_write_data(buffer_u8, i);
			
			with (objMinigame1vs3_Showdown_Block) {
				if (player_id == i) {
					buffer_write_data(buffer_u8, number);
					break;
				}
			}
			
			network_send_tcp_packet();
		}
	}
	
	with (objMinigame1vs3_Showdown_Block) {
		if (self.number == -1) {
			return;
		}
	}
	
	with (objMinigameController) {
		alarm_call(4, 1);
	}
}

action_end = function() {
	alarm_stop(1);
	alarm_stop(4);
	
	with (objMinigame1vs3_Showdown_Block) {
		number = -1;
		selecting = false;
	}
}

player_type = objPlayerPlatformer;

rounds = -1;

alarm_override(1, function() {
	if (minigame1vs3_lost()) {
		with (minigame1vs3_solo()) {
			if (network_id == global.player_id && other.rounds == 0) {
				achieve_trophy(13);
			}
		
			minigame4vs_points(network_id);	
		}
	
		minigame_finish();
		return;
	}

	if (++rounds == instance_number(objMinigame1vs3_Showdown_Rounds)) {
		var survived = true;
		var below = false;
	
		for (var i = 0; i < minigame1vs3_team_length(); i++) {
			with (minigame1vs3_team(i)) {
				if (lost) {
					survived = false;
				}
			
				if (network_id == global.player_id) {
					below = true;
				}
			
				minigame4vs_points(network_id);
			}
		}
	
		if (survived && below) {
			achieve_trophy(12);
		}
	
		minigame_finish();
		return;
	}

	with (objMinigame1vs3_Showdown_Block) {
		number = -1;
	
		if (is_player_local(player_id)) {
			selecting = true;
		}
	}

	minigame_time = 5;
	alarm_call(10, 1);
});

alarm_create(4, function() {
	var up_number = -1;

	with (objMinigame1vs3_Showdown_Block) {
		if (y < 304) {
			up_number = number;
			break;
		}
	}

	with (objMinigame1vs3_Showdown_Block) {
		if (y > 304 && number == up_number) {
			instance_destroy();
		}
	}

	with (objMinigame1vs3_Showdown_Rounds) {
		if (number == other.rounds) {
			image_index = 1;
			break;
		}
	}
	
	alarm_call(1, 2);
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		if (irandom(3) == 0) {
			continue;
		}
		
		switch (irandom(2)) {
			case 0: actions.left.press(); break;
			case 1: actions.right.press(); break;
			case 2: actions.jump.press(); break;
		}
	}

	alarm_call(11, 0.5);
});