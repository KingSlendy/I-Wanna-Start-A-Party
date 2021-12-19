animation_state = 1;
var my_info = get_player_info(player_id);
my_info.shines += amount;
my_info.shines = clamp(my_info.shines, 0, 999);
calculate_player_place();