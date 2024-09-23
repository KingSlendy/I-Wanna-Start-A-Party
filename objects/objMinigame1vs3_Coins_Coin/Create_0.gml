coin_id = -1;

next_seed_inline();

if (object_index == objMinigame1vs3_Coins_Coin && irandom(998) == 0) {
	sprite_index = sprMinigame1vs3_Coins_RedCoin;
}

gravity = 0.3;

function coin_obtain(network_id, network = true) {
	if (minigame1vs3_is_solo(network_id)) {
		minigame4vs_points(network_id, 1);
	}
	
	instance_destroy();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Coins_CoinObtain);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u16, coin_id);
		network_send_tcp_packet();
	}
}