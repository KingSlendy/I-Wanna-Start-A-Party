event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		max_hspd = 0.5;
		enable_jump = false;
		enable_shoot = false;
		won = false;
		move_delay_timer = 0;
		add_delay = false;
		make_move = false;
	}
}

action_end = function() {
	with (objMinigame4vs_Haunted_Boo) {
		image_index = 0;
		image_xscale = -5;
		alarm_stop(0);
		alarm_stop(1);
		alarm_stop(2);
	}
}

player_type = objPlayerPlatformer;
state = 0;

if (trial_is_title(HAUNTED_REFLEXES)) {
	minigame_time = 50;
}

alarm_override(0, function() {
	if (state++ == 1) {
		alarm_inherited(0);
		next_seed_inline();
	
		with (objMinigame4vs_Haunted_Boo) {
			alarm_call(0, random_range(2, 4));
		}
	} else {
		with (objMinigame4vs_Haunted_Boo) {
			alarm_call(0, 0.5);
		}
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
			if (--move_delay_timer > 0) {
				break;
			}
			
			if (!objMinigame4vs_Haunted_Boo.lookout) {
				make_move = true;
				
				if (add_delay && move_delay_timer <= 0) {
					move_delay_timer = get_frames(random_range(0.2, 0.3));
					add_delay = false;
					break;
				}
			
				actions.right.press();
			} else {
				add_delay = true;
				
				if (make_move) {
					if (0.75 > random(1)) {
						actions.right.hold(get_frames(random_range(0.4, 0.5)));
					} else {
						actions.right.hold(get_frames(random_range(0.6, 0.8)));
					}
					
					make_move = false;
				}
			}
		}
	}

	alarm_frames(11, 1);
});