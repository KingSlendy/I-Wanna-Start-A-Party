function network_read_host(ip, port, socket, buffer) {
	buffer_seek_begin(buffer);
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
	switch (data_id) {
		case Client_TCP.PlayerMove:
			buffer_reconstruct(buffer, data_id);
			network_send_tcp_except(socket);
			break;
	}
}

function network_read_host_udp(ip, port, buffer, data_id) {
	switch (data_id) {
		case Client_UDP.Heartbeat:
			var player_id = buffer_read(buffer, buffer_u16);
		
			if (player_id != 0) {
				global.player_list_host[player_id - 1].port = port;
			}
			
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