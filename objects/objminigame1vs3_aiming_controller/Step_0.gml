if (!input_start || info.is_finished) {
	exit;
}

if (minigame1vs3_lost()) {
	if (global.player_id == minigame1vs3_solo().network_id && trophy_saver) {
		achieve_trophy(52);
	}
	
	minigame_time_end();
	exit;
}

shoot_delay = max(--shoot_delay, 0);

if (shoot_delay == 0 && global.actions.shoot.pressed(minigame1vs3_solo().network_id)) {
	var laser = objMinigame1vs3_Aiming_Spike;
	create_laser(laser.x, laser.y);
	shoot_delay = get_frames(1.75);
		
	buffer_seek_begin();
	buffer_write_action(ClientTCP.Minigame1vs3_Aiming_LaserShoot);
	buffer_write_data(buffer_s32, laser.x);
	buffer_write_data(buffer_s32, laser.y);
	network_send_tcp_packet();
}

for (var i = 0; i < minigame1vs3_team_length(); i++) {
	var player = minigame1vs3_team(i);
	
	with (objMinigame1vs3_Aiming_Block) {
		if (is_player && i == player_num) {
			hspd = max_hspd * (global.actions.right.held(player.network_id) - global.actions.left.held(player.network_id));
			move_block();
			break;
		}
	}
}