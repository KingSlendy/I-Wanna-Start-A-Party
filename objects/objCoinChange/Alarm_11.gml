animation_state = 1;
player_info.coins += amount;
player_info.coins = clamp(player_info.coins, 0, 999);
calculate_player_place();