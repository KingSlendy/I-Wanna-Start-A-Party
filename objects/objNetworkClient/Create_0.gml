if (instance_number(object_index) > 1) {
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

network_set_config(network_config_connect_timeout, 10000);
network_set_config(network_config_use_non_blocking_socket, true);
network_connect_async(global.tcp_socket, global.ip, global.port);

alarms_init(2);

alarm_create(function() {
	popup("A network error occurred.");
	instance_destroy();
});

alarm_create(function() {
	buffer_seek_begin();
	buffer_write_action(ClientUDP.Initialize);
	buffer_write_data(buffer_u64, global.master_id);
	network_send_udp_packet();
	alarm_call(1, 1);
});