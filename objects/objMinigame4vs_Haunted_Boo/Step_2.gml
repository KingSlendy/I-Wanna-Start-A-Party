if (objMinigameController.info.is_finished || targeting || returning) {
	exit;
}

if (sign(image_xscale) == -1) {
	with (objPlayerBase) {
		if (!is_player_local(network_id)) {
			continue;
		}
		
		if (hspd != 0 && !array_contains(other.player_targets, network_id)) {
			array_push(other.player_targets, network_id);
			
			buffer_seek_begin();
			buffer_write_action(ClientTCP.Minigame4vs_Haunted_Boo);
			buffer_write_data(buffer_u8, network_id);
			network_send_tcp_packet();
		}
	}
	
	if (array_length(player_targets) > 0) {
		start_target_player();
	}
}