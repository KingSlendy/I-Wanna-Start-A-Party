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
global.player_id = 0;
global.lobby_started = false;
global.game_id = "";
global.player_game_ids = [];
player_leave_all();

if (room == rFiles) {
	with (objFiles) {
		online_reading = false;
		
		if (menu_type != 3) {
			menu_type = 1;
		}
	}
} else {
	room_goto(rFiles);
}