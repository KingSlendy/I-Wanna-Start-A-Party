animation_state = 1;
player_turn_info.coins += amount;
player_turn_info.coins = clamp(player_turn_info.coins, 0, 999);
calculate_player_place();