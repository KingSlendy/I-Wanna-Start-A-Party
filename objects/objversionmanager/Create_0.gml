if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

text = "Checking version...";
version = "";
size = 0;
downloading = false;
bytes = null;
sent = 0;
socket = network_create_socket(network_socket_tcp);

if (socket < 0) {
	print("Failed to create TCP socket.");
	instance_destroy();
	exit;
}

network_set_config(network_config_connect_timeout, 10000);
network_set_config(network_config_use_non_blocking_socket, true);
network_connect_async(socket, "startaparty.sytes.net", 33320);