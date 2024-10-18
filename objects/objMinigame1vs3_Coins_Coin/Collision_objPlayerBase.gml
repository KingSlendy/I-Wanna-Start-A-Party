if (is_player_local(other.network_id) && !other.frozen) {
	if (!objMinigameController.info.is_finished) {
		coin_obtain(other.network_id);
	}
	
	audio_play_sound(sndMinigame1vs3_Coins_Coin, 0, false);
	instance_destroy();
}

if (other.network_id == global.player_id) {
	objMinigameController.trophy_coin = false;
	
	if (sprite_index == sprMinigame1vs3_Coins_RedCoin) {
		achieve_trophy(16);
	}
}