animation_state = 1;
var player_turn_info = get_player_turn_info();
player_turn_info.shines += amount;
player_turn_info.shines = clamp(player_turn_info.shines, 0, 999);
calculate_player_place();