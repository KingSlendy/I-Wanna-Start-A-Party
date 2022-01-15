if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

global.ip = get_string("Enter IP", "127.0.0.1");
	
if (global.ip == null) {
	popup("Process has been cancelled.");
	instance_destroy();
	exit;
}

global.tcp_socket = network_create_socket(network_socket_tcp);

if (global.tcp_socket < 0) {
	popup("Failed to create TCP socket.");
	instance_destroy();
	exit;
}

global.udp_socket = network_create_socket(network_socket_udp);

if (global.udp_socket < 0) {
	popup("Failed to create UDP socket.");
	instance_destroy();
	exit;
}

global.player_name = get_string("Enter your name.", "Player");
objPlayerBase.network_name = global.player_name;
network_connect_async(global.tcp_socket, global.ip, global.port);