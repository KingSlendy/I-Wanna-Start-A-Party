function slime_shot(network = true) {
	sprite_index = sprMinigame4vs_Slime_SlimeShot;
	image_index = 4;
	var player = focus_player_by_turn(objMinigameController.player_turn);
	
	if (is_player_local(player.network_id)) {
		player.frozen = true;
	}
	
	audio_play_sound(sndMinigame4vs_Slime_Shot, 0, false);
	music_pause();
	next_seed_inline();
	alarm[0] = get_frames(irandom_range(2, 4));
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Slime_SlimeShot);
		network_send_tcp_packet();
	}
}