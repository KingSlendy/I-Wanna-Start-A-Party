function slime_blocking(network = true) {
	with (objMinigameController) {
		block_entrance();
	}

	instance_destroy();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_SlimeBlocking);
		network_send_tcp_packet();
	}
}