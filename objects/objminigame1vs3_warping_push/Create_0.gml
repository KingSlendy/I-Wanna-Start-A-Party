gravity = 0.3;
pushable = true;

function push_block(player, network = true) {
	if (!pushable || player.bbox_bottom <= bbox_top) {
		return;
	}
	
	x += 2 * sign(player.hspd);
	x = min(x, xstart + 32 * 3);
	
	if (x >= xstart + 32 * 3) {
		gain_trophy(37);
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Warping_Push);
		buffer_write_data(buffer_s32, x);
		network_send_tcp_packet();
	}
}