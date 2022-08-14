alarms_destroy();
network_destroy(socket);

if (bytes != null) {
	buffer_delete(bytes);
}