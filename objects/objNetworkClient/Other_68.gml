if (async_load[? "type"] == network_type_data) {
	var ip = async_load[? "ip"];
	var port = async_load[? "port"];
	var buffer = async_load[? "buffer"];
	network_read_client(ip, port, buffer);
}