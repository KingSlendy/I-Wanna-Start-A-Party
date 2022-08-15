with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	max_hspd = 0.5;
	enable_jump = false;
	enable_shoot = false;
	won = false;
	move_delay_timer = 0;
}

event_inherited();

action_end = function() {
	with (objMinigame4vs_Haunted_Boo) {
		image_index = 0;
		image_xscale = -5;
		alarm_stop(0);
		alarm_stop(1);
		alarm_stop(2);
	}
}

player_check = objPlayerPlatformer;
state = 0;

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
		
		if (sign(objMinigame4vs_Haunted_Boo.image_xscale) == 1) {
			actions.right.press();
		} else {
			if (irandom(10) == 0) {
				actions.right.hold(get_frames(0.5));
			}
		}
	}

	alarm_frames(11, 1);
});