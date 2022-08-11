image_alpha = 0;
image_index = irandom(image_number - 1);
alpha_target = 0;
can_switch = true;
player = null;

function curtain_switch(network = true) {
	if (!can_switch || point_distance(image_alpha, 0, alpha_target, 0) > 0.00001) {
		return;
	}
	
	alpha_target ^= true;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Magic_CurtainSwitch);
		buffer_write_data(buffer_u8, player.network_id);
		network_send_tcp_packet();
	}
}