if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

if (global.ip == null) {
	global.ip = get_string("Enter IP", "127.0.0.1");
	
	if (global.ip == null) {
		show_message("Process has been cancelled.");
		instance_destroy(objNetworkHost);
		instance_destroy();
		exit;
	}
}

if (global.port == null) {
	global.port = get_integer("Enter port (0-65535)", 33321);
	
	if (global.port == null) {
		show_message("Process has been cancelled.");
		instance_destroy(objNetworkHost);
		instance_destroy();
		exit;
	}
}

global.tcp_socket = network_create_socket(network_socket_tcp);

if (global.tcp_socket < 0) {
	show_message("Failed to create TCP socket.");
	instance_destroy(objNetworkHost);
	instance_destroy();
	exit;
}

if (global.udp_socket == null) {
	global.udp_socket = network_create_socket(network_socket_udp);

	if (global.udp_socket < 0) {
		show_message("Failed to create UDP socket.");
		instance_destroy(objNetworkHost);
		instance_destroy();
		exit;
	}
}

if (network_connect(global.tcp_socket, global.ip, global.port) < 0) {
	show_message("Failed to connect to server.");
	instance_destroy(objNetworkHost);
	instance_destroy();
	exit;
}

global.player_name = get_string("Enter your name.", "Player");