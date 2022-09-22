event_inherited();

minigame_start = minigame1vs3_start;
minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

minigame_time = 20;
minigame_time_end = function() {
	if (!points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_type = objPlayerPlatformer;
house_start = false;

function cherry_move(move, network = true) {
	with (objMinigame1vs3_House_Cherry) {
		x += move * 3;
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
		if (network) {
			if (y != ystart) {
				return;
			}
		} else {
			y = ystart;
		}
		
		vspeed = -9;
		gravity = 0.3;
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_House_CherryJump);
		network_send_tcp_packet();
	}
}

alarm_override(1, function() {
	points_teams[1][0].frozen = false;
	house_start = true;
});

alarm_override(11, function() {
	for (var i = 2; i <= global.player_max; i++) {
		var actions = check_player_actions_by_id(i);

		if (actions == null) {
			continue;
		}
	
		var keys = ["left", "right", "jump"];
		var action = actions[$ keys[irandom(array_length(keys) - 1)]];
		
		switch (irandom(2)) {
			case 0:
				action.hold(irandom(21));
				break;
				
			case 1:
				action.press();
				break;
				
			case 2:
				action.release(true);
				break;
		}
	}

	alarm_frames(11, 1);
});