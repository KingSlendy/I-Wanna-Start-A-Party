event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		enable_jump = false;
		enable_shoot = false;
		chest_picked = -1;
		chest_delay = irandom_range(8, 14);
	}
}

minigame_time_end = function() {
	if (alarm_is_stopped(6)) {
		alarm_call(6, 1);
	}
	
	chest_show = true;
	
	var one_selected = false;
	
	with (objMinigame4vs_Chests_Chest) {
		if (selected == global.player_id) {
			one_selected = true;
			break;
		}
	}
	
	if (!one_selected) {
		trophy_chests = false;
	}
}

action_end = function() {
	if (trophy_chests && info.player_scores[global.player_id - 1].points == 0) {
		achieve_trophy(63);
	}
}

points_draw = true;
player_type = objPlayerPlatformer;
chest_started = false;
chest_show = false;

next_seed_inline();
chest_switches = [];

repeat (50) {
	var switches = array_sequence(0, 4);
	array_shuffle(switches);
	array_delete(switches, 0, 2);
	array_push(chest_switches, switches);
}

current_switch = 0;
chest_round = 0;
trophy_chests = true;

alarm_override(1, function() {
	alarm_inherited(1);

	if (++chest_round == 4) {
		minigame_finish();
		return;
	}

	with (objMinigame4vs_Chests_Chest) {
		alarm_frames(0, 1);
	}

	minigame_time = -1;
	chest_started = true;
	chest_show = false;
});

alarm_create(4, function() {
	var moving = false;

	with (objMinigame4vs_Chests_Chest) {
		if (target_switched) {
			moving = true;
			break;
		}
	}

	alarm_frames(4, 1);

	if (moving) {
		exit;
	}

	var switches = chest_switches[current_switch];
	var chests = [null, null];

	with (objMinigame4vs_Chests_Chest) {
		if (n == switches[0]) {
			chests[0] = id;
		}
	
		if (n == switches[1]) {
			chests[1] = id;
		}
	}

	with (chests[0]) {
		switch_target(chests[1].x, chests[1].y);
	}

	with (chests[1]) {
		switch_target(chests[0].x, chests[0].y);
	}

	current_switch++;
	audio_play_sound(sndMinigame4vs_Chests_Move, 0, false);
});

alarm_create(5, function() {
	alarm_stop(4);
	var moving = false;

	with (objMinigame4vs_Chests_Chest) {
		if (target_switched) {
			moving = true;
			break;
		}
	}

	if (moving) {
		alarm_frames(5, 1);
		return;
	}

	with (objMinigame4vs_Chests_Chest) {
		switch_target(, target_y + 300);
		selectable = true;
	}

	current_switch = 0;
	minigame_time = 8;
	alarm_call(10, 1);
});

alarm_create(6, function() {
	with (objMinigame4vs_Chests_Chest) {
		image_index = 1;
		target_y = ystart;
		alarm_call(3, 0.5);
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
			if (chest_picked == -1) {
				chest_picked = irandom(3);
			}
		
			var chest = null;
		
			with (objMinigame4vs_Chests_Chest) {
				if (n == other.chest_picked) {
					if (selected == -1) {
						chest = id;
					} else {
						other.chest_picked = -1;
					}
				
					break;
				}
			}
		
			if (chest == null) {
				break;
			}
		
			if (place_meeting(x, y, chest)) {
				if (--chest_delay > 0) {
					break;
				}
				
				actions.up.press();
				chest_delay = irandom_range(8, 14);
				break;
			}
		
			if (point_distance(x, y, chest.x, y) < 4) {
				break;
			}
		
			var dir = point_direction(x, y, chest.x, y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.press();
		}
	}

	alarm_frames(11, 1);
});