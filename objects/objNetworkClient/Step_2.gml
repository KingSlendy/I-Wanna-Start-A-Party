if (global.player_id != 0 && global.udp_socket != null) {
	buffer_seek_begin();
	buffer_write_action(ClientUDP.Heartbeat);
	buffer_write_data(buffer_u8, global.player_id);
	network_send_udp_packet();
}