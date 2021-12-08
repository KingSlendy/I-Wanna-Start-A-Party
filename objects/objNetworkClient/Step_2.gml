buffer_seek_begin();
buffer_write_from_host(false);
buffer_write_action(Client_UDP.Heartbeat);
buffer_write_data(buffer_u16, global.player_id);
network_send_udp_packet();