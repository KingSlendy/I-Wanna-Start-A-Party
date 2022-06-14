depth = 200;
image_speed = 0;
player = null;
link = null;
linked = false;

function open_door(network = true) {
	if (image_speed > 0) {
		return;
	}
	
	image_speed = 1;
	audio_play_sound(sndMinigame4vs_Mansion_OpenDoor, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Mansion_Door);
		buffer_write_data(buffer_u8, row);
		buffer_write_data(buffer_u8, col);
		network_send_tcp_packet();
	}
}
