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
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var buffer = async_load[? "buffer"];
		
		try {
			buffer_seek_begin(buffer);
			
			if (!downloading) {
				version = buffer_read(buffer, buffer_string);
				size = buffer_read(buffer, buffer_u64);
					
				if (version != VERSION) {
					bytes = buffer_create(size, buffer_fixed, 1);
					buffer_seek_begin(bytes);
					text = "Downloading version...";
					downloading = true;
				} else {
					alarm_instant(0);
					exit;
				}
			} else {
				var check = buffer_get_size(buffer);
				buffer_copy(buffer, 0, check, bytes, sent);
				sent += check;
					
				if (sent == size) {
					text = "Finished download!";
					buffer_save(bytes, "Version.zip");
					zip_unzip("Version.zip", game_save_id);
					file_delete("Version.zip");
					buffer_delete(bytes);
					execute_shell_simple(game_save_id + "update.bat",,, 0);
					alarm_call(1, 3);
					alarm_stop(2);
					exit;
				}
			}
		} catch (_) {
			text = "An error ocurred...";
			alarm_call(0, 3);
			exit;
		}
		
		alarm_call(2, 15);
		break;
}