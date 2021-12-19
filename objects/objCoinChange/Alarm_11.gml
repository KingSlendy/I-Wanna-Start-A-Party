animation_state = 1;
var my_info = get_player_info(player_id);
my_info.coins += amount;
my_info.coins = clamp(my_info.coins, 0, 999);
calculate_player_place();