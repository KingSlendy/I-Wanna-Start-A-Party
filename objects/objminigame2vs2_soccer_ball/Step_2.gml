if (global.player_id != 1) {
	exit;
}

buffer_seek_begin();
buffer_write_action(ClientUDP.Minigame2vs2_Soccer_Ball);
buffer_write_data(buffer_s32, x);
buffer_write_data(buffer_s32, y);
buffer_write_data(buffer_f16, hspeed);
buffer_write_data(buffer_f16, vspeed);
buffer_write_data(buffer_f16, gravity);
network_send_udp_packet();