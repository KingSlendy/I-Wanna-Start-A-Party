if (global.udp_ready) {
	buffer_seek_begin();
	buffer_write_action(ClientUDP.Heartbeat);
	buffer_write_data(buffer_u64, global.master_id);
	network_send_udp_packet();
}