if (state == 0) {
	scale += 0.05;
	
	if (scale >= 1) {
		scale = 1;
		state = -2;
		alarm[1] = 1;
		alarm[2] = game_get_speed(gamespeed_fps) * ((additional == 0) ? 5 : 0.5);
	}
} else if (state == 1) {
	scale -= 0.05;
	
	if (scale <= 0) {
		scale = 0;
		state = -1;
	}
}

if (state == -2 && is_player_turn() && global.jump_action.pressed()) {
	steal_count -= 0.1;
	
	buffer_seek_begin();
	//buffer_write_action(Client_TCP.LessStealCount);
	//network_send_tcp_packet();
}