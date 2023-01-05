event_inherited();

minigame_players = function() {
	objPlayerBase.action_delay = 0;
}

points_draw = true;
player_type = objPlayerPlatformer;

player_turn = 1;
player_bullets = array_create(global.player_max, 6);
next_turn = -1;
end_turn = function() {
	objPlayerBase.frozen = true;
	alarm_pause(10);
	
	if (player_turn < global.player_max && !trial_is_title(PERFECT_AIM)) {
		next_turn = 0;
	} else {
		minigame_finish();
	}

	var player = focus_player_by_turn(player_turn);

	if (player.network_id == global.player_id && minigame4vs_get_points(player.network_id) == 0) {
		achieve_trophy(59);
	}
}

minigame_time_end = end_turn;
trophy_yellow = true;

function unfreeze_player() {
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
	minigame_time = 15;
	alarm_call(10, 1);
	
	if (trial_is_title(PERFECT_AIM)) {
		minigame_time = -1;
		alarm_stop(10);
	}
}

function reposition_player() {
	var player = focus_player_by_turn(player_turn);
	var prev_player = focus_player_by_turn(player_turn - 1);
	
	with (objPlayerReference) {
		if (reference == 0) {
			player.x = x + 17;
			player.y = y + 23;
			break;
		}
	}
	
	with (objPlayerReference) {
		if (reference == other.player_turn - 1) {
			prev_player.x = x + 17;
			prev_player.y = y + 23;
			break;
		}
	}
	
	with (objMinigame4vs_Targets_Target) {
		restore_target();
	}
}

alarm_override(1, function() {
	unfreeze_player();
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (--action_delay > 0) {
				break;
			}
			
			if (!place_meeting(x + 1, y, objBlock)) {
				actions.right.press();
				break;
			}
			
			if (on_block && vspd == 0) {
				actions.jump.hold(23);
				break;
			}
			
			if (vspd >= 0) {
				if (jump_left > 0) {
					actions.jump.hold(irandom_range(3, 7));
				} else {
					actions.shoot.press();
					action_delay = get_frames(random_range(0.5, 1.5));
				}
			}
		}
	}

	alarm_frames(11, 1);
});