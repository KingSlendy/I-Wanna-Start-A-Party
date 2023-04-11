event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 20;
minigame_time_end = function() {
	if (!minigame1vs3_solo().lost) {
		minigame4vs_points(minigame1vs3_solo().network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;
house_start = false;

function cherry_move(move, network = true) {
	with (objMinigame1vs3_House_Cherry) {
		if (y < 608) {
			x += move * 4;
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_House_CherryMove);
		buffer_write_data(buffer_s8, move);
		network_send_tcp_packet();
	}
}

function cherry_jump(network = true) {
	with (objMinigame1vs3_House_Cherry) {
		if (y < 608) {
			if (network) {
				if (y != ystart) {
					return;
				}
			} else {
				y = ystart;
			}
		
			vspeed = -8.5;
			gravity = 0.3;
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_House_CherryJump);
		network_send_tcp_packet();
	}
}

alarm_override(1, function() {
	minigame1vs3_solo().frozen = false;
	house_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var player = focus_player_by_id(i);
		
		with (player) {
			if (minigame1vs3_is_solo(i)) {
				if (place_meeting(x - 32, y, objMinigame1vs3_House_Cherry)) {
					actions.right.hold(irandom_range(4, 9));
				}
				
				if (place_meeting(x + 32, y, objMinigame1vs3_House_Cherry)) {
					actions.left.hold(irandom_range(4, 9));
				}
				
				if (place_meeting(x, y + 16, objMinigame1vs3_House_Cherry) && 0.75 > random(1)) {
					actions.jump.hold(irandom_range(13, 16));
				}
			} else {
				if (minigame1vs3_team(0).network_id == i) {
					var action = actions.left;
				} else if (minigame1vs3_team(1).network_id == i) {
					var action = actions.right;
				} else {
					var action = actions.jump;
				}
				
				if (0.1 > random(1)) {
					action.hold(irandom_range(5, 10));
				}
			}
		}
	}

	alarm_frames(11, 1);
});