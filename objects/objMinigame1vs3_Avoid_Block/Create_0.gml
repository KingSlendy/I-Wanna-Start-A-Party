attack = image_index;

function activate(image, network = false) {
	with (object_index) {
		if (image_index == image) {
			//alarm[image] = 1;
			alarm[1] = 10;
		}
	
		image_index = image_number - 1;
		alarm[10] = get_frames(3);
		alarm[11] = get_frames(2);
	
		if (!network) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame1vs3_Avoid_Block);
			buffer_write_data(buffer_u8, attack);
			network_send_tcp_packet();
		}
	}
}
