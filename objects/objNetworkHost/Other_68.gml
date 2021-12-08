var type = async_load[? "type"];

switch (type) {
	case network_type_connect:
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var socket = async_load[? "socket"];
		player_join(player_number, ip, port, socket, true);
		buffer_seek_begin();
		buffer_write_from_host(true);
		buffer_write_action(Client_TCP.ReceiveID);
		buffer_write_data(buffer_u8, player_number);
		network_send_tcp_packet(socket);
		
		buffer_seek_begin();
		buffer_write_from_host(true);
		buffer_write_action(Client_TCP.PlayerConnect);
		buffer_write_data(buffer_u8, player_number);
		network_send_tcp_except(socket);
		player_number++;
		break;

	case network_type_disconnect:
		var socket = async_load[? "socket"];
		var player_id = 0;
		
		for (var i = 0; i < global.player_max; i++) {
			var player = global.player_list_host[i];
			
			if (player != null && player.socket == socket) {
				player_id = i + 1;
				break;
			}
		}
		
		player_leave(player_id, true);
		buffer_seek_begin();
		buffer_write_from_host(true);
		buffer_write_action(Client_TCP.PlayerDisconnect);
		buffer_write_data(buffer_u8, player_id);
		network_send_tcp_except(socket);
		player_number--;
		break;
		
	case network_type_data:
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var socket = async_load[? "id"];
		var buffer = async_load[? "buffer"];
		network_read_host(ip, port, socket, buffer);
		break;
}