with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 30;
minigame_time_end = function() {
	if (!points_teams[1][0].lost) {
		minigame4vs_points(points_teams[1][0].network_id);
	} else {
		minigame1vs3_points();
	}
	
	minigame_finish();
}

player_check = objPlayerPlatformer;
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
		if (vspeed != 0) {
			continue;
		}
		
		vspeed = -6;
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