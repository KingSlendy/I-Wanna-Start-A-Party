if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

global.ip = get_string("Enter IP", "127.0.0.1");

if (global.ip == null) {
	show_message("Process has been cancelled.");
	instance_destroy();
	exit;
}

global.port = get_integer("Enter port (0-65535)", 33321);

if (global.port == null) {
	show_message("Process has been cancelled.");
	instance_destroy();
	exit;
}

server = network_create_server(network_socket_tcp, global.port, global.player_max);

if (server < 0) {
	show_message("Failed to create TCP server!");
	instance_destroy();
	exit;
}

global.udp_socket = network_create_socket_ext(network_socket_udp, global.port);

if (global.udp_socket < 0) {
	show_message("Failed to create UDP server!");
	instance_destroy();
	exit;
}

player_number = 1;
instance_create_layer(0, 0, "Managers", objNetworkClient);