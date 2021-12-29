//buffer_seek_begin();
//buffer_write_action(Client_UDP.SendSound);
//network_send_udp_packet();
buffer_seek_begin();
buffer_write_action(Client_TCP.SendTest);
buffer_write_data(buffer_s16, 3);
buffer_write_data(buffer_u8, 1);
network_send_tcp_packet();