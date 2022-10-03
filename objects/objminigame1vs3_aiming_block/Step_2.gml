if (!is_player || !is_player_local(minigame1vs3_team(player_num).network_id)) {
	exit;
}

buffer_seek_begin();
buffer_write_action(ClientUDP.Minigame1vs3_Aiming_Block);
buffer_write_data(buffer_bool, is_player);
buffer_write_data(buffer_u8, player_num);
buffer_write_data(buffer_s32, x);
buffer_write_data(buffer_s32, y);
network_send_udp_packet();