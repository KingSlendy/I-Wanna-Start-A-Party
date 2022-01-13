global.ip = null;

if (global.tcp_socket >= 0) {
	network_destroy(global.tcp_socket);
}

global.tcp_socket = null;

if (global.udp_socket >= 0) {
	network_destroy(global.udp_socket);
}

global.udp_socket = null;
global.player_client_list = array_create(global.player_max, null);
global.player_id = 0;
global.player_name = "";
instance_destroy(objNetworkPlayer);