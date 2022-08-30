depth = layer_get_depth("Tiles") - 1;

function grab_coin(player_id, network = true) {
	var count = 0;
	
	with (object_index) {
		count += (id != other.id && image_blend == other.image_blend);
	}
	
	if (count == 0) {
		minigame4vs_points(player_id);
		minigame_finish();
		
		if (player_id == global.player_id && objMinigameController.trophy_none) {
			gain_trophy(51);
		}
	}
	
	audio_play_sound(sndMinigame4vs_Dizzy_Coin, 0, false);
	instance_destroy();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Dizzy_GrabCoin);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}