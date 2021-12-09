buffer_seek_begin();
buffer_write_from_host(false);
buffer_write_action(Client_TCP.Test);
network_send_tcp_packet();