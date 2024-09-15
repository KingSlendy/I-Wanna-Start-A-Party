function treasure_obtained(network_id, network = true) {
	minigame4vs_set_points(network_id);
	minigame_finish();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Treasure_Obtained);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}