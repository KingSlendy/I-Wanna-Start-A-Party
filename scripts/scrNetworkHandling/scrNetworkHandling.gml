global.ip = null;
global.port = null;
global.tcp_socket = null;
global.udp_socket = null;
global.player_max = 4;
global.player_list_host = array_create(global.player_max, null);
global.player_list_client = array_create(global.player_max, null);
global.player_id = 0;
global.player_name = "";

function buffer_seek_begin(buffer = global.buffer) {
	buffer_seek(buffer, buffer_seek_start, 0);
}

function buffer_write_from_host(value) {
	buffer_write(global.buffer, buffer_bool, value);
}

function buffer_write_action(id) {
	buffer_write(global.buffer, buffer_u16, id);
}

function buffer_write_data(type, value) {
	buffer_write(global.buffer, type, value);
}

function buffer_push(buffer, type, value) {
	var data = [];
	var size = buffer_tell(buffer);
	buffer_seek_begin(buffer);
	
	repeat (size) {
		array_push(data, buffer_read(buffer, buffer_u8));
	}
	
	buffer_seek_begin(buffer);
	buffer_write(buffer, type, value);
	
	for (var i = 0; i < size; i++) {
		buffer_write(buffer, buffer_u8, data[i]);
	}
}

function buffer_reconstruct(buffer, data_id) {
	var data = [];

	try {
		while (true) {
			array_push(data, buffer_read(buffer, buffer_u8));
		}
	} catch (_) {
		//Nothing
	}
	
	buffer_seek_begin();
	buffer_write_from_host(true);
	buffer_write_action(data_id);
	
	for (var i = 0; i < array_length(data); i++) {
		buffer_write_data(buffer_u8, data[i]);
	}
}

function buffer_sanity_checks(is_tcp) {
	var size = buffer_tell(global.buffer) + 4;
	buffer_push(global.buffer, buffer_bool, is_tcp);
	buffer_push(global.buffer, buffer_u16, size);
	buffer_push(global.buffer, buffer_u8, FAILCHECK_ID);
}

function network_send_tcp_packet(socket = global.tcp_socket, send_all = false) {
	if (!send_all) {
		buffer_sanity_checks(true);
	}
	
	network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
}

function network_send_udp_packet(ip = global.ip, port = global.port, send_all = false) {
	if (!send_all) {
		buffer_sanity_checks(false);
	}
	
	network_send_udp(global.udp_socket, ip, port, global.buffer, buffer_tell(global.buffer));
}

function network_send_tcp_except(socket) {
	buffer_sanity_checks(true);
	
	for (var i = 0; i < global.player_max; i++) {
		var player = global.player_list_host[i];
		
		if (player != null && player.socket != socket) {
			network_send_tcp_packet(player.socket, true);
		}
	}
}

function network_send_udp_except(ip) {
	buffer_sanity_checks(false);
	
	for (var i = 0; i < global.player_max; i++) {
		var player = global.player_list_host[i];
		
		if (player != null && player.ip != ip) {
			network_send_udp_packet(player.ip, player.port, true);
		}
	}
}

function NetworkPlayer(ip, port, socket) constructor {
	self.ip = ip;
	self.port = port;
	self.socket = socket;
	
	static toString = function() {
		return "(" + self.ip + ", " + string(self.port) + ", " + string(self.socket) + ")";
	}
}

function player_join(id, ip, port, socket = null, host = false) {
	if (host) {
		global.player_list_host[id - 1] = new NetworkPlayer(ip, port, socket);
	} else {
		if (id != global.player_id) {
			var p = instance_create_layer(0, 0, "Instances", objNetworkPlayer);
			p.network_id = id;
			global.player_list_client[id - 1] = p;
		}
	}
}

function player_leave(id, host = false) {
	if (host) {
		global.player_list_host[id - 1] = null;
	} else {
		instance_destroy(global.player_list_client[id - 1]);
		global.player_list_client[id - 1] = null;
	}
}

function player_write_data() {
	buffer_write_data(buffer_u8, global.player_id);
	buffer_write_data(buffer_string, global.player_name);
	
	with (objPlayerBase) {
		buffer_write_data(buffer_u16, sprite_index);
		buffer_write_data(buffer_s16, x);
		buffer_write_data(buffer_s16, y);
		buffer_write_data(buffer_s8, image_xscale);
		buffer_write_data(buffer_s8, image_yscale);
		buffer_write_data(buffer_u8, image_alpha);
	}
	
	buffer_write_data(buffer_s16, room);
}

function player_read_data(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var instance = global.player_list_client[player_id - 1];
		
	if (instance != null) {
		instance.network_name = buffer_read(buffer, buffer_string);
		instance.sprite_index = buffer_read(buffer, buffer_u16);
		instance.x = buffer_read(buffer, buffer_s16);
		instance.y = buffer_read(buffer, buffer_s16);
		instance.image_xscale = buffer_read(buffer, buffer_s8);
		instance.image_yscale = buffer_read(buffer, buffer_s8);
		instance.image_alpha = buffer_read(buffer, buffer_u8);
		instance.network_room = buffer_read(buffer, buffer_s16);
	}
}