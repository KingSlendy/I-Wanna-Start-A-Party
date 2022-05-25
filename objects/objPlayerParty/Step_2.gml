if (global.player_id != 0 && global.tcp_socket != null) {
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.PlayerMove);
	player_write_data();
	network_send_tcp_packet();
}