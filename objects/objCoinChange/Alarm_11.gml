animation_state = 1;
var player_turn_info = get_player_turn_info();
player_turn_info.coins += amount;
player_turn_info.coins = clamp(player_turn_info.coins, 0, 999);
calculate_player_place();