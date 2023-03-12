if (!selectable || selected != -1 || y != target_y || !is_player_local(other.network_id) || other.frozen) {
	exit;
}

if (global.actions.up.pressed(other.network_id)) {
	selected = other.network_id;
	other.frozen = true;
	target_y = ystart - 32;
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.Minigame4vs_Chests_ChestSelected);
	buffer_write_data(buffer_u8, n);
	buffer_write_data(buffer_u8, selected);
	network_send_tcp_packet();
}