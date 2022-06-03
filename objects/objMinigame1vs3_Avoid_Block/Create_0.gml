attack = image_index;
dir = 1;

function activate(image, network = false) {
	if (image_index == image_number - 1) {
		return;
	}
	
	with (object_index) {
		if (image_index == image) {
			alarm[image] = 10;
			//alarm[4] = 10;
			
			if (!network) {
				buffer_seek_begin();
				buffer_write_action(ClientTCP.Minigame1vs3_Avoid_Block);
				buffer_write_data(buffer_u8, image);
				network_send_tcp_packet();
			}
		}
	
		image_index = image_number - 1;
		alarm[10] = get_frames(2.4);
		alarm[11] = get_frames(2);
	}
}
