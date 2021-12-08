buffer_seek_begin();
buffer_write_from_host(false);
buffer_write_action(Client_UDP.Test);
network_send_udp_packet();