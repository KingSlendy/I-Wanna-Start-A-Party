buffer_seek_begin();
buffer_write_action(ClientUDP.Initialize);
buffer_write_data(buffer_u64, global.master_id);
network_send_udp_packet();
alarm[1] = get_frames(1);