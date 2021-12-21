function network_read_host(ip, port, socket, buffer) {
	if (buffer_get_size(buffer) == 0) {
		return;
	}
	
	buffer_seek_begin(buffer);
	var match_id = buffer_read(buffer, buffer_u8);
		
	if (match_id != FAILCHECK_ID) {
		return;
	}
		
	var match_size = buffer_read(buffer, buffer_u16);
	
	if (buffer_get_size(buffer) != match_size) {
		return;
	}
	
	var is_tcp = buffer_read(buffer, buffer_bool);
	var from_host = buffer_read(buffer, buffer_bool);
	var data_id = buffer_read(buffer, buffer_u16);
	
	if (!from_host) {
		if (is_tcp) {
			network_read_host_tcp(socket, buffer, data_id);
		} else {
			network_read_host_udp(ip, port, buffer, data_id);
		}
	}
}

function network_read_host_tcp(socket, buffer, data_id) {
	buffer_reconstruct(buffer, data_id);
	network_send_tcp_except(socket);
}

function network_read_host_udp(ip, port, buffer, data_id) {
	switch (data_id) {
		case Client_UDP.Heartbeat:
			var player_id = buffer_read(buffer, buffer_u16);
		
			if (player_id != 0) {
				global.player_list_host[player_id - 1].port = port;
			}
			
			buffer_seek_begin();
			buffer_write_from_host(true);
			buffer_write_action(Client_UDP.Heartbeat);
			network_send_udp_packet(ip, port);
			break;
			
		default:
			var has_ip = false;
	
			for (var i = 0; i < global.player_max; i++) {
				var player = global.player_list_host[i];
		
				if (player != null && player.ip == ip) {
					has_ip = true;
					break;
				}
			}
	
			if (has_ip) {
				buffer_reconstruct(buffer, data_id);
				network_send_udp_except(ip);
			}
			break;
	}
}