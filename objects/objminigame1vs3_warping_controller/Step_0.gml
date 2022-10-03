if (minigame1vs3_solo().lost) {
	minigame_finish(true);
}

if (!warp_start || info.is_finished) {
	exit;
}

for (var i = 0; i < array_length(points_teams[0]); i++) {
	var player = minigame1vs3_team(i);
	warp_delay[i] = max(--warp_delay[i], 0);
	
	if (warp_delay[i] == 0 && global.actions.shoot.pressed(player.network_id)) {
		var warp_x = player.x - 17;
		var warp_y = player.y - 42;
		create_warp(warp_x, warp_y);
		warp_delay[i] = get_frames(0.75);
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Warping_Warp);
		buffer_write_data(buffer_s32, warp_x);
		buffer_write_data(buffer_s32, warp_y);
		network_send_tcp_packet();
	}
}