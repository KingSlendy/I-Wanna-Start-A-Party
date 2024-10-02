#macro IS_ONLINE (instance_exists(objNetworkClient))

global.tcp_socket = null;
global.udp_socket = null;
global.buffer = buffer_create(1024, buffer_fixed, 1);
global.player_max = 4;
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

function player_join(player_id, player_name = "") {
	var player;
	
	if (player_id == global.player_id) {
		player = instance_create_layer(0, 0, "Actors", objPlayerBase);
		player.network_id = global.player_id;
		player.network_name = global.player_name;
		return;
	}
	
	player = focus_player_by_id(player_id);
		
	if (player != null && player.ai) {
		instance_destroy(player);
	}
		
	if (player == null) {
		player = instance_create_layer(0, 0, "Actors", objNetworkPlayer);
		player.network_id = player_id;
		player.network_name = player_name;
	} else {
		with (player) {
			online = true;
			alarm_stop(11);
		}
	}
	
	window_flash(window_flash_timernofg, 1, 150);
}

function player_leave(player_id) {
	var player = focus_player_by_id(player_id);
	
	if (!player.online) {
		return;
	}
	
	if (!global.lobby_started) {
		//Calculate the maximum ID of all the connected players
		var max_id = 1;
		
		with (objPlayerBase) {
			if (online) {
				max_id = max(max_id, network_id);
			}
		}
		
		//Move the local player by one spot
		if (player_id < global.player_id) {
			player_swap(global.player_id, global.player_id - 1);
			global.player_id--;
		}
		
		//Disable the empty spaces that generated after the player disconnected
		for (var i = global.player_max; i >= max_id; i--) {
			with (focus_player_by_id(i)) {
				network_name = "";
				online = false;
			}
		}
		
		return;
	} else if (room == rModes) {
		with (objModes) {
			back_to_files();
		}
		
		return;
	}
	
	popup(player.network_name + " disconnected.\nExiting lobby.");
	network_disable();
}

function player_join_all() {
	for (var i = 1; i <= global.player_max; i++) {
		if (focus_player_by_id(i) == null) {
			player_join(i);
		}
	}
	
	for (var i = 1; i < global.player_id; i++) {
		player_join(i);
	}
}

function player_leave_all() {
	instance_destroy(objPlayerBase);
}

function ai_join_all() {
	for (var i = 2; i <= global.player_max; i++) {
		if (!focus_player_by_id(i).online) {
			ai_join(i);
		}
	}
}

function ai_join(player_id) {
	var player = focus_player_by_id(player_id);
	
	if (player != null && !is_player_local(player_id)) {
		instance_destroy(player);
	}
	
	var a = instance_create_layer(800, 304, "Actors", objPlayerBase);
	a.network_id = player_id;
	a.network_name = "CPU " + string(player_id);
	a.ai = true;
}

function ai_leave(player_id) {
	var ai = focus_player_by_id(player_id);
	
	if (ai != null && ai.ai) {
		instance_destroy(ai);
	}
	
	player_join(player_id);
}

function player_swap(player_id1, player_id2) {
	var temp_player1 = focus_player_by_id(player_id1);
	var temp_player2 = focus_player_by_id(player_id2);
	temp_player1.network_id = player_id2;
	temp_player2.network_id = player_id1;
}

function player_write_data() {
	buffer_seek_begin();
	buffer_write_action(ClientUDP.PlayerData);
	buffer_write_data(buffer_u8, network_mode);
	buffer_write_data(buffer_u8, network_id);
	buffer_write_data(buffer_bool, ai);
	buffer_write_data(buffer_u16, object_index);
	buffer_write_data(buffer_u16, room);
	buffer_write_data(buffer_u16, sprite_index);
	buffer_write_data(buffer_f16, image_alpha);
	buffer_write_data(buffer_s8, image_xscale);
	buffer_write_data(buffer_s8, image_yscale);
	
	if (object_index == objPlayerPlatformer || object_index == objPlayerBasic || object_index == objPlayerStatic || object_index == objPlayerBubble) {
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
		case PlayerDataMode.Basic:
			buffer_write_data(buffer_bool, spinning);
			buffer_write_data(buffer_f16, spin_index);
			break;
		
		case PlayerDataMode.Hand:
			buffer_write_data(buffer_u8, image_index);
			break;
			
		case PlayerDataMode.Rocket:
			buffer_write_data(buffer_u8, hp);
			buffer_write_data(buffer_s8, speed);
			break;
			
		case PlayerDataMode.Hammer:
			buffer_write_data(buffer_u8, index);
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
	var instance = focus_player_by_id(network_id);
		
	if (instance == null) {
		return;
	}
	
	with (instance) {
		alarm_call(11, 11);
		
		ai = buffer_read(buffer, buffer_bool);
		network_index = buffer_read(buffer, buffer_u16);
		network_room = buffer_read(buffer, buffer_u16);
		sprite_index = buffer_read(buffer, buffer_u16);
		image_alpha = buffer_read(buffer, buffer_f16);
		image_xscale = buffer_read(buffer, buffer_s8);
		image_yscale = buffer_read(buffer, buffer_s8);
		
		if (network_index == objPlayerPlatformer || network_index == objPlayerBasic || network_index == objPlayerStatic || network_index == objPlayerBubble) {
			xscale = buffer_read(buffer, buffer_s8);
			orientation = buffer_read(buffer, buffer_s8);
		}
		
		image_angle = buffer_read(buffer, buffer_u16);
		x = buffer_read(buffer, buffer_s32);
		y = buffer_read(buffer, buffer_s32);
		
		switch (mode) {
			case PlayerDataMode.Basic:
				spinning = buffer_read(buffer, buffer_bool);
				spin_index = buffer_read(buffer, buffer_f16);
				break;
			
			case PlayerDataMode.Hand:
				image_index = buffer_read(buffer, buffer_u8);
				break;
				
			case PlayerDataMode.Rocket:
				hp = buffer_read(buffer, buffer_u8);
				spd = buffer_read(buffer, buffer_s8);
				break;
				
			case PlayerDataMode.Hammer:
				index = buffer_read(buffer, buffer_u8);
				break;
				
			case PlayerDataMode.Golf:
				aiming = buffer_read(buffer, buffer_bool);
				powering = buffer_read(buffer, buffer_bool);
				aim_angle = buffer_read(buffer, buffer_u16);
				aim_power = buffer_read(buffer, buffer_f16);
				break;
		}
	}
}

function obtain_same_game_key(game_key = "Nothing") {
	var board_game = global.board_games[$ global.game_id];
	var my_game_key = (board_game != null) ? board_game.saved_key : "Nothing";
	
	if (global.player_id > 1 && my_game_key != game_key) {
		my_game_key = "Nothing";
	}
		
	buffer_seek_begin();
	buffer_write_action(ClientTCP.BoardGameKey);
	buffer_write_data(buffer_u8, global.player_id + 1);
	buffer_write_data(buffer_string, my_game_key);
	network_send_tcp_packet();
	
	check_same_game_key(global.player_id + 1, my_game_key);
}

function check_same_game_key(player_id, game_key) {
	if (player_id < (global.player_max - get_ai_count()) + 1) {
		return false;
	}
	
	var board_game = global.board_games[$ global.game_id];
	
	if (board_game != null && board_game.saved_key == game_key && get_ai_count() == board_game.saved_ai_count) {
		global.game_key = game_key;

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
	global.master_id = 0;
	global.player_id = 1;
	global.lobby_started = false;
	global.game_id = "";
	global.game_key = "";
	global.player_game_ids = [];
	player_leave_all();

	if (room == rFiles && !global.lobby_started) {
		with (objFiles) {
			online_reading = false;
		
			if (menu_type != 3) {
				menu_type = 1;
			}
		}
			
		return;
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
	//instance_activate_object(obj_gmlive);
	application_surface_draw_enable(true);
	
	if (room != rFiles) {
		audio_stop_all();
	}
	
	global.game_started = false;
}