var type = async_load[? "type"];

switch (type) {
	case network_type_non_blocking_connect:
		var succeeded = async_load[? "succeeded"];
		
		if (succeeded == 0) {
			alarm[2] = 1;
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
			buffer_seek(buffer, buffer_seek_start, 0);
			
			if (!downloading) {
				version = buffer_read(buffer, buffer_string);
				size = buffer_read(buffer, buffer_u64);
					
				if (version != VERSION) {
					bytes = buffer_create(size, buffer_fast, 1);
					buffer_seek(bytes, buffer_seek_start, 0);
					text = "Downloading version...";
					downloading = true;
				} else {
					instance_destroy();
				}
			} else {
				var check = buffer_get_size(buffer);
				buffer_copy(buffer, 0, check, bytes, sent);
				sent += check;
					
				if (sent == size) {
					text = "Downloaded version!";
					buffer_save(bytes, "Version.zip");
					zip_unzip("Version.zip", game_save_id);
					file_delete("Version.zip");
					execute_shell_simple(game_save_id + "update.bat");
					alarm[1] = get_frames(3);
					alarm[2] = 0;
					exit;
				}
			}
		} catch (_) {
			alarm[2] = 1;
			exit;
		}
		
		alarm[2] = get_frames(10);
		break;
}