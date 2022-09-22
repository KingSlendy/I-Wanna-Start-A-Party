if (!objMinigameController.info.is_finished && is_player_local(other.network_id) && !other.frozen) {
	minigame4vs_points(other.network_id, 1);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.Minigame1vs3_Coins_Coin);
	buffer_write_data(buffer_u8, other.network_id);
	network_send_tcp_packet();
}

audio_play_sound(sndMinigame1vs3_Coins_Coin, 0, false);
instance_destroy();

if (other.network_id == global.player_id && sprite_index == sprMinigame1vs3_Coins_RedCoin) {
	achieve_trophy(16);
}
