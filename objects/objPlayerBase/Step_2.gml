if (global.player_id != 0 && global.udp_socket != null) {
	player_write_data();
	send_timer = 0;
}