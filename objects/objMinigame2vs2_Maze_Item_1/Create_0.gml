function collect_item(player) {
	if (objMinigameController.started && !player.has_item && player_info_by_id(player.network_id).space == image_blend) {
		player.has_item = true;
		var h = instance_create_layer(0, 0, "Actors", objMinigame2vs2_Maze_HasItem);
		h.focus_player = player.id;
		h.image_index = image_index;
		h.image_blend = image_blend;
		instance_destroy();
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Maze_Item);
		buffer_write_data(buffer_u8, player.network_id);
		buffer_write_data(buffer_s16, x);
		buffer_write_data(buffer_s16, y);
		network_send_tcp_packet();
	}
}