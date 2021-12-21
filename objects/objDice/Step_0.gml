if (is_player_turn() && objPlayerBoard.can_jump && global.shoot_action.pressed()) {
	objPlayerBoard.can_jump = false;
	instance_destroy();
	
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.HideDice);
	network_send_tcp_packet();
}