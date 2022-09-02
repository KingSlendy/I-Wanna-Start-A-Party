var type = async_load[? "type"];

switch (type) {
	case network_type_non_blocking_connect:
		var succeeded = async_load[? "succeeded"];
		
		if (succeeded == 0) {
			alarm_frames(2, 1);
		}
		break;
		
	case network_type_disconnect:
		instance_destroy();
		break;
		
	case network_type_data:
		var buffer = async_load[? "buffer"];
		buffer_seek_begin(buffer);
		version = buffer_read(buffer, buffer_text);
					
		if (version != VERSION) {
			file = http_get_file(string_interp("https://github.com/KingSlendy/I-Wanna-Start-A-Party/releases/download/{0}/I_Wanna_Start_A_Party.zip", version), game_save_id + "\\Version.zip");
		} else {
			alarm_instant(0);
			exit;
		}
		break;
}