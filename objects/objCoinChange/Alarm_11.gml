animation_state = 1;
player_info.coins += amount;
player_info.coins = clamp(player_info.coins, 0, 999);

if (player_info.network_id == global.player_id) {
	if (player_info.coins >= 100) {
		gain_trophy(5);
	}

	if (player_info.coins <= 0) {
		gain_trophy(6);
	}
}

calculate_player_place();