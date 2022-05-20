if (global.player_id != 0 && global.udp_socket != null && send_timer++ >= 0) {
	player_write_data();
	send_timer = 0;
}