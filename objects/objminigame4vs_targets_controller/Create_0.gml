event_inherited();

minigame_players = function() {
	objPlayerBase.action_delay = 0;
}

points_draw = true;
player_type = objPlayerPlatformer;

player_turn = 1;
player_bullets = array_create(global.player_max, 6);
next_turn = -1;
trophy_yellow = true;

function unfreeze_player() {
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
}

function reposition_player() {
	var player = focus_player_by_turn(player_turn);
	var prev_player = focus_player_by_turn(player_turn - 1);
	
	with (objPlayerReference) {
		if (reference == 1) {
			player.x = x + 17;
			player.y = y + 23;
			break;
		}
	}
	
	with (objPlayerReference) {
		if (reference == other.player_turn) {
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