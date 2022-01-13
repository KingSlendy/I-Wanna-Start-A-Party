global.ip = null;
global.port = 33321;
global.tcp_socket = null;
global.udp_socket = null;
global.buffer = buffer_create(1024, buffer_fixed, 1);
global.player_max = 4;
global.player_client_list = array_create(global.player_max, null);
global.player_id = 0;
global.player_name = "";

function buffer_seek_begin(buffer = global.buffer) {
	buffer_seek(buffer, buffer_seek_start, 0);
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

function buffer_sanity_checks(is_tcp) {
	var size = buffer_tell(global.buffer) + 4;
	buffer_push(global.buffer, buffer_bool, is_tcp);
	buffer_push(global.buffer, buffer_u16, size);
	buffer_push(global.buffer, buffer_u8, FAILCHECK_ID);
}

function buffer_write_array(type, array) {
	buffer_write_data(buffer_u16, array_length(array));
	
	for (var i = 0; i < array_length(array); i++) {
		buffer_write_data(type, array[i]);
	}
}

function buffer_read_array(buffer, type) {
	var length = buffer_read(buffer, buffer_u16);
	var array = [];
	
	repeat (length) {
		array_push(array, buffer_read(buffer, type));
	}

	return array;
}

function network_send_tcp_packet() {
	buffer_sanity_checks(true);
	network_send_packet(global.tcp_socket, global.buffer, buffer_tell(global.buffer));
}

function network_send_udp_packet() {
	buffer_sanity_checks(false);
	network_send_udp_raw(global.udp_socket, global.ip, global.port, global.buffer, buffer_tell(global.buffer));
}

function player_join(id) {
	if (id != global.player_id) {
		var player = global.player_client_list[id - 1];
		
		if (player != null && player.ai) {
			instance_destroy(player);
			global.player_client_list[id - 1] = null;
		}
		
		if (player == null) {
			var p = instance_create_layer(0, 0, "Instances", objNetworkPlayer);
			p.network_id = id;
			global.player_client_list[id - 1] = p;
		} else {
			player.visible = true;
		}
	}
}

function player_leave(id) {
	if (id != global.player_id) {
		global.player_client_list[id - 1].visible = false;
	}
}

function ai_join(id) {
	var player = global.player_client_list[id - 1];
	
	if (player != null && player.object_index == objNetworkPlayer) {
		instance_destroy(player);
	}
	
	var a = instance_create_layer(800, 304, "Instances", objPlayerMovement8);
	a.network_id = id;
	a.ai = true;
	a.alarm[0] = 1; //Temp
	global.player_client_list[id - 1] = a;
}

function ai_leave(id) {
	var ai = global.player_client_list[id - 1];
	
	if (ai != null && ai.ai) {
		instance_destroy(ai);
	}
	
	player_join(id);
}

function player_write_data() {
	buffer_write_data(buffer_u8, network_id);
	buffer_write_data(buffer_string, global.player_name);
	buffer_write_data(buffer_u16, sprite_index);
	buffer_write_data(buffer_s16, x);
	buffer_write_data(buffer_s16, y);
	buffer_write_data(buffer_s8, image_xscale);
	buffer_write_data(buffer_s8, image_yscale);
	buffer_write_data(buffer_u8, image_alpha);
	buffer_write_data(buffer_u16, room);
}

function player_read_data(buffer) {
	var player_id = buffer_read(buffer, buffer_u8);
	var instance = global.player_client_list[player_id - 1];
		
	if (instance != null) {
		instance.visible = true;
		instance.network_name = buffer_read(buffer, buffer_string);
		instance.sprite_index = buffer_read(buffer, buffer_u16);
		instance.x = buffer_read(buffer, buffer_s16);
		instance.y = buffer_read(buffer, buffer_s16);
		instance.image_xscale = buffer_read(buffer, buffer_s8);
		instance.image_yscale = buffer_read(buffer, buffer_s8);
		instance.image_alpha = buffer_read(buffer, buffer_u8);
		instance.network_room = buffer_read(buffer, buffer_u16);
	}
}