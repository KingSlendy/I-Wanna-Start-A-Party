if (other.num == goal_num + 1 || (other.num == 0 && goal_num == 3)) {
	goal_num = other.num;
	
	if (goal_num == 0) {
		minigame4vs_points(network_id, 1);
		
		if (minigame4vs_get_points(network_id) == 4) {
			minigame_finish(true);
		}
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Bubble_Goal);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}