function slime_next(network = true) {
	with (objMinigameController) {
		unfreeze_player();
	}

	instance_destroy();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_SlimeNext);
		network_send_tcp_packet();
	}
}