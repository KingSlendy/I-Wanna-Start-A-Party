#macro IS_ONLINE (instance_exists(objNetworkClient))

global.tcp_socket = null;
global.udp_socket = null;
global.udp_ready = false;
global.buffer = buffer_create(1024, buffer_fixed, 1);
global.player_max = 4;
global.player_client_list = array_create(global.player_max, null);
global.master_id = 0;
global.player_id = 1;
global.lobby_started = false;

enum PlayerDataMode {
	Heartbeat,
	Basic,
	Hand,
	Rocket,
	Hammer,
	Golf
}

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
	if (IS_ONLINE) {
		buffer_sanity_checks(true);
		network_send_packet(global.tcp_socket, global.buffer, buffer_tell(global.buffer));
	}
}

function network_send_udp_packet() {
	if (IS_ONLINE) {
		buffer_sanity_checks(false);
		network_send_udp_raw(global.udp_socket, global.ip, global.port, global.buffer, buffer_tell(global.buffer));
	}
}

function player_join_all() {
	for (var i = 1; i <= global.player_max; i++) {
		if (global.player_client_list[i - 1] == null) {
			player_join(i);
		}
	}
}

function player_leave_all() {
	instance_destroy(objPlayerBase);
	global.player_client_list = array_create(global.player_max, null);
}

function player_join(id) {
	if (id != global.player_id) {
		var player = global.player_client_list[id - 1];
		
		if (player != null && player.ai) {
			instance_destroy(player);
			global.player_client_list[id - 1] = null;
		}
		
		if (player == null) {
			var p = instance_create_layer(0, 0, "Actors", objNetworkPlayer);
			p.network_id = id;
			global.player_client_list[id - 1] = p;
		} else {
			player.draw = true;
		}
	} else {
		var player = instance_create_layer(0, 0, "Actors", objPlayerBase);
		player.network_id = global.player_id;
		player.network_name = global.player_name;
	}
}

function player_leave(player_id) {
	if (player_id != global.player_id) {
		var player = global.player_client_list[player_id - 1];
		player.draw = false;
		player.network_name = "";
	}
}

function player_disconnection(player_id) {
	if (!global.lobby_started) {
		with (objPlayerBase) {
			player_leave(network_id);
		}
		
		if (player_id < global.player_id) {
			with (focus_player_by_id(global.player_id)) {
				network_id--;
			}
				
			global.player_id--;
		}
		
		return;
	} else if (room == rModes) {
		with (objModes) {
			back_to_files();
		}
		
		return;
	}
	
	popup(focus_player_by_id(player_id).network_name + " disconnected.\nExiting lobby.");
	network_disable();
}

function ai_join_all() {
	for (var i = 2; i <= global.player_max; i++) {
		if (!focus_player_by_id(i).draw) {
			ai_join(i);
		}
	}
}

function ai_join(id) {
	var player = global.player_client_list[id - 1];
	
	if (player != null && !is_player_local(id)) {
		instance_destroy(player);
	}
	
	var a = instance_create_layer(800, 304, "Actors", objPlayerBase);
	a.network_id = id;
	a.network_name = "CPU " + string(id);
	a.ai = true;
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
	buffer_seek_begin();
	buffer_write_action(ClientUDP.PlayerData);
	buffer_write_data(buffer_u8, network_mode);
	buffer_write_data(buffer_u8, network_id);
	buffer_write_data(buffer_string, network_name);
	buffer_write_data(buffer_bool, ai);
	buffer_write_data(buffer_u16, object_index);
	buffer_write_data(buffer_u16, room);
	buffer_write_data(buffer_u16, sprite_index);
	buffer_write_data(buffer_f16, image_alpha);
	buffer_write_data(buffer_s8, image_xscale);
	buffer_write_data(buffer_s8, image_yscale);
	
	if (object_index == objPlayerPlatformer || object_index == objPlayerBasic) {
		buffer_write_data(buffer_s8, xscale);
		buffer_write_data(buffer_s8, orientation);
	}
	
	if (network_mode != PlayerDataMode.Golf) {
		buffer_write_data(buffer_u16, image_angle);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
	} else {
		buffer_write_data(buffer_u16, -phy_rotation % 360);
		buffer_write_data(buffer_s32, phy_position_x);
		buffer_write_data(buffer_s32, phy_position_y);
	}
	
	switch (network_mode) {
		case PlayerDataMode.Hand: case PlayerDataMode.Hammer:
			buffer_write_data(buffer_u8, image_index);
			break;
			
		case PlayerDataMode.Rocket:
			buffer_write_data(buffer_u8, hp);
			buffer_write_data(buffer_s8, speed);
			break;
			
		case PlayerDataMode.Golf:
			buffer_write_data(buffer_bool, aiming);
			buffer_write_data(buffer_bool, powering);
			buffer_write_data(buffer_u16, aim_angle);
			buffer_write_data(buffer_f16, aim_power);
			break;
	}
	
	network_send_udp_packet();
}

function player_read_data(buffer) {
	var mode = buffer_read(buffer, buffer_u8);
	var network_id = buffer_read(buffer, buffer_u8);
	var instance = global.player_client_list[network_id - 1];
		
	if (instance != null) {
		with (instance) {
			alarm_call(11, 11);
		}
		
		instance.network_name = buffer_read(buffer, buffer_string);
		instance.ai = buffer_read(buffer, buffer_bool);
		instance.network_index = buffer_read(buffer, buffer_u16);
		instance.network_room = buffer_read(buffer, buffer_u16);
		instance.sprite_index = buffer_read(buffer, buffer_u16);
		instance.image_alpha = buffer_read(buffer, buffer_f16);
		instance.image_xscale = buffer_read(buffer, buffer_s8);
		instance.image_yscale = buffer_read(buffer, buffer_s8);
		
		if (instance.network_index == objPlayerPlatformer || instance.network_index == objPlayerBasic) {
			instance.xscale = buffer_read(buffer, buffer_s8);
			instance.orientation = buffer_read(buffer, buffer_s8);
		}
		
		instance.image_angle = buffer_read(buffer, buffer_u16);
		instance.x = buffer_read(buffer, buffer_s32);
		instance.y = buffer_read(buffer, buffer_s32);
		
		switch (mode) {
			case PlayerDataMode.Hand: case PlayerDataMode.Hammer:
				instance.image_index = buffer_read(buffer, buffer_u8);
				break;
				
			case PlayerDataMode.Rocket:
				instance.hp = buffer_read(buffer, buffer_u8);
				instance.spd = buffer_read(buffer, buffer_s8);
				break;
				
			case PlayerDataMode.Golf:
				instance.aiming = buffer_read(buffer, buffer_bool);
				instance.powering = buffer_read(buffer, buffer_bool);
				instance.aim_angle = buffer_read(buffer, buffer_u16);
				instance.aim_power = buffer_read(buffer, buffer_f16);
				break;
		}
	}
}

function obtain_same_game_id(names = variable_struct_get_names(global.board_games)) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.BoardGameID);
	buffer_write_data(buffer_u8, global.player_id + 1);
	buffer_write_array(buffer_string, names);
	network_send_tcp_packet();
	
	check_same_game_id(global.player_id + 1, names);
}

function check_same_game_id(player_id, received_names) {
	if (player_id < (global.player_max - get_ai_count()) + 1) {
		return false;
	}
	
	if (array_length(received_names) > 0 && get_ai_count() == global.board_games[$ received_names[0]].saved_ai_count) {
		global.game_id = received_names[0];

		with (objPlayerBase) {
			change_to_object(objPlayerBoardData);
		}
	} else {
		instance_destroy(objBoardGame);
	}
				
	return true;
}

function obtain_player_game_ids(player_ids = []) {
	player_ids[global.player_id - 1] = global.board_games[$ global.game_id].saved_id;
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.BoardPlayerIDs);
	buffer_write_data(buffer_u8, global.player_id + 1);
	buffer_write_array(buffer_u8, player_ids);
	network_send_tcp_packet();
	
	check_player_game_ids(global.player_id + 1, player_ids);
}

function check_player_game_ids(player_id, player_ids) {	
	if (player_id < (global.player_max - get_ai_count()) + 1) {
		return false;
	}
	
	for (var i = 1; i <= global.player_max; i++) {
		if (i > array_length(player_ids)) {
			array_push(player_ids, i);
		}
	}
	
	global.player_game_ids = player_ids;
	instance_destroy(objBoardGame);
	return true;
}

function network_reset() {
	if (global.tcp_socket >= 0) {
		network_destroy(global.tcp_socket);
	}

	global.tcp_socket = null;

	if (global.udp_socket >= 0) {
		network_destroy(global.udp_socket);
	}

	global.udp_socket = null;
	global.udp_ready = false;
	global.player_client_list = array_create(global.player_max, null);
	global.master_id = 0;
	global.player_id = 1;
	global.lobby_started = false;
	global.game_id = "";
	global.player_game_ids = [];
	player_leave_all();

	if (room == rFiles && !global.lobby_started) {
		if (global.lobby_started) {
			with (objFiles) {
				online_reading = false;
		
				if (menu_type != 3) {
					menu_type = 1;
				}
			}
			
			return;
		}
	}
	
	room_goto(rFiles);
}

function network_disable() {
	with (all) {
		if (object_index == objFiles) {
			continue;
		}
		
		try {
			event_perform(ev_cleanup, 0);
		} catch (_) {}
	}
	
	network_reset();
	instance_destroy(objNetworkClient, false);
	instance_destroy(objPlayerInfo);
	instance_deactivate_all(false);
	instance_activate_object(objGameManager);
	instance_activate_object(objFiles);
	instance_activate_object(obj_gmlive);
	application_surface_draw_enable(true);
	
	if (room != rFiles) {
		audio_stop_all();
	}
	
	global.game_started = false;
}