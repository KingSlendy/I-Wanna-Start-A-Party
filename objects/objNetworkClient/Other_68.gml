var type = async_load[? "type"];

switch (type) {
	case network_type_non_blocking_connect:
		var succeeded = async_load[? "succeeded"];
		
		if (succeeded < 0) {
			popup("Failed to connect to server.");
			instance_destroy();
		}
		break;
		
	case network_type_data:
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var buffer = async_load[? "buffer"];
		network_read_client(ip, port, buffer);
		break;
}