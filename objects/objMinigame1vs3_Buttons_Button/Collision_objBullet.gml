if (!is_player_local(other.network_id)) {
	exit;
}

if (image_index == 1) {
	press_button(other.network_id);
	instance_destroy(other);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.Minigame1vs3_Buttons_Button);
	buffer_write_data(buffer_u8, other.network_id);
	buffer_write_data(buffer_bool, inside);
	buffer_write_data(buffer_u8, objMinigameController.buttons_outside_current);
	buffer_write_data(buffer_u8, objMinigameController.buttons_inside_current);
	network_send_tcp_packet();
}
