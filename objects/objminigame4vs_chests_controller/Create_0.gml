with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	chest_picked = -1;
}

event_inherited();

points_draw = true;
player_check = objPlayerPlatformer;
chest_started = false;

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

alarm_override(1, function() {
	alarm_inherited(1);

	if (++chest_round == 4) {
		minigame_finish();
		return;
	}

	with (objMinigame4vs_Chests_Chest) {
		alarm_frames(0, 1);
	}

	chest_started = true;
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
			if (frozen) {
				break;
			}
		
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
		
			var me_x = x - 1;
			var me_y = y - 7;
		
			if (place_meeting(x, y, chest)) {
				actions.up.press();
				break;
			}
		
			if (point_distance(me_x, me_y, chest.x, me_y) < 4) {
				break;
			}
		
			var dir = point_direction(me_x, me_y, chest.x, me_y);
			var action = (dir == 0) ? actions.right : actions.left;
			action.press();
		}
	}

	alarm_frames(11, 1);
});