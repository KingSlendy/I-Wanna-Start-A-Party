buffer_seek_begin();
buffer_write_action(ClientTCP.LobbyStart);
buffer_write_data(buffer_u64, global.master_id);
network_send_tcp_packet();