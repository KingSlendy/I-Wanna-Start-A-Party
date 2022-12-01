if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

text = "Checking version...";
version = "";
file = null;
downloading = false;
size = 0;
sent = 0;
socket = network_create_socket(network_socket_tcp);

if (socket < 0) {
	print("Failed to create TCP socket.");
	instance_destroy();
	exit;
}

network_set_config(network_config_connect_timeout, 10000);
network_set_config(network_config_use_non_blocking_socket, true);
network_connect_raw_async(socket, "startaparty.sytes.net", 33320);

function occurred_error() {
	text = "An error ocurred...";
	alarm_call(0, 3);
}

alarms_init(3);

alarm_create(function() {
	instance_destroy();
});

alarm_create(function() {
	game_end();
});

alarm_create(function() {
	text = "Connection timeout!";
	downloading = false;
	alarm_call(0, 3);
});

alarm_call(2, 15);