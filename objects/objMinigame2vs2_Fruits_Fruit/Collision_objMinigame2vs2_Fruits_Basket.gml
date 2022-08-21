if (y < other.bbox_bottom) {
	var player_id = other.follow.network_id;
	
	if (is_player_local(player_id)) {
		minigame4vs_points(player_id, type + 1);
	
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Fruits_Fruit);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_s8, type + 1);
		network_send_tcp_packet();
	}
	
	instance_destroy();
}