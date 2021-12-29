if (is_player_turn() && objPlayerBoard.can_jump && global.shoot_action.pressed()) {
	objPlayerBoard.can_jump = false;
	layer_sequence_headpos(sequence, layer_sequence_get_length(sequence));
	layer_sequence_headdir(sequence, -1);
	layer_sequence_play(sequence);
	
	buffer_seek_begin();
	buffer_write_action(Client_TCP.HideDice);
	network_send_tcp_packet();
}