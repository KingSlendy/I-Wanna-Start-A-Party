depth = 299;
player_id = 0;

function platform_paint(new_id, network = true) {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	if (player_id != 0) {
		minigame4vs_points(player_id, -1);
	}
	
	player_id = new_id;
	minigame4vs_points(player_id, 1);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Painting_Platform);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		buffer_write_data(buffer_u8, new_id);
		network_send_tcp_packet();
	}
}
