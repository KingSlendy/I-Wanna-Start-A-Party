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
			var data_id = buffer_read(buffer, buffer_u16);
			
			switch (data_id) {
				case ClientVER.SendVersion:
					size = buffer_read(buffer, buffer_u64);
					version = buffer_read(buffer, buffer_string);
					
					if (version != VERSION) {
						bytes = buffer_create(size, buffer_fast, 1);
						buffer_seek(bytes, buffer_seek_start, 0);
						
						if (file_exists(version + ".zip")) {
							file_delete(version + ".zip");
						}
						
						text = "Downloading version...";
						downloading = true;
					} else {
						instance_destroy();
					}
					break;
					
				case ClientVER.Executable:
					var check = buffer_get_size(buffer) - 2;
					
					repeat (check) {
						buffer_write(bytes, buffer_u8, buffer_read(buffer, buffer_u8));
					}
					
					sent += check;
					
					if (sent == size) {
						text = "Downloaded version!";
						var path = get_save_filename_ext("ZIP|*.zip", version + ".zip", program_directory, "Save Version");
						
						if (path == "") {
							text = "Cancelled saving.";
							exit;
						}
						
						buffer_save(bytes, path);
						alarm[1] = get_frames(3);
						alarm[2] = 0;
						exit;
					}
					break;
			}
		} catch (_) {
			alarm[2] = 1;
			exit;
		}
		
		alarm[2] = get_frames(10);
		break;
}