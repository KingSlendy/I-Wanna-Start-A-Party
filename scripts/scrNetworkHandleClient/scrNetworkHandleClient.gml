enum Client_TCP {
	ReceiveID,
	PlayerConnect,
	PlayerDisconnect,
	PlayerMove
}

enum Client_UDP {
	Heartbeat,
	PlayerMove
}

function network_read_client(ip, port, buffer) {
	if (buffer_get_size(buffer) == 0) {
		return;
	}
	
	buffer_seek_begin(buffer);
	var match_id = buffer_read(buffer, buffer_u8);
	
	if (match_id != FAILCHECK_ID) {
		return;
	}
		
	var match_size = buffer_read(buffer, buffer_u16);
	
	if (buffer_get_size(buffer) + 5 != match_size) {
		return;
	}
		
	var is_tcp = buffer_read(buffer, buffer_bool);
	var from_host = buffer_read(buffer, buffer_bool);
	var data_id = buffer_read(buffer, buffer_u16);
	
	if (from_host) {
		if (is_tcp) {
			network_read_client_tcp(ip, port, buffer, data_id);
		} else {
			network_read_client_udp(buffer, data_id);
		}
	}
}

function network_read_client_tcp(ip, port, buffer, data_id) {
	switch (data_id) {
		case Client_TCP.ReceiveID:
			global.player_id = buffer_read(buffer, buffer_u8);
			
			for (var i = 0; i < global.player_id; i++) {
				if (global.player_list_client[i] == null) {
					player_join(i + 1, ip, port);
				}
			}
			break;
			
		case Client_TCP.PlayerConnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_join(player_id, ip, port);
			break;
				
		case Client_TCP.PlayerDisconnect:
			var player_id = buffer_read(buffer, buffer_u8);
			player_leave(player_id);
			break;
			
		case Client_TCP.PlayerMove:
			player_read_data(buffer);
			break;
	}
}

function network_read_client_udp(buffer, data_id) {
	switch (data_id) {
		case Client_UDP.Heartbeat:
			objNetworkClient.alarm[0] = game_get_speed(gamespeed_fps) * 3;
			break;
		
		case Client_UDP.PlayerMove:
			player_read_data(buffer);
			break;
	}
}