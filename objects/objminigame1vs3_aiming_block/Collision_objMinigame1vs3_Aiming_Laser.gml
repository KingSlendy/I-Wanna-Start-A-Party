instance_destroy(other);

if (is_player) {
	var player = minigame1vs3_team(player_num);

	if (!is_player_local(player.network_id)) {
		exit;
	}

	player.lost = true;
	var sfx_break = sndDeath;
} else {
	objMinigameController.trophy_saver = false;
	var sfx_break = sndBlockBreak;
	
	if (global.player_id != 1) {
		exit;
	}
}

buffer_seek_begin();
buffer_write_action(ClientTCP.Minigame1vs3_Aiming_DestroyBlock);
buffer_write_data(buffer_bool, is_player);
buffer_write_data(buffer_u8, player_num);
network_send_tcp_packet();

audio_play_sound(sfx_break, 0, false);
instance_destroy();