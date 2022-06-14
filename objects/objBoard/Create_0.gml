if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

//depth = -10000;

fade_start = true;
fade_alpha = 1;

with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

//Board controllers
global.board_started = false;
global.board_first_space = array_create(global.player_max, true);
global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choice_selected = -1;

//Board values
global.max_board_turns = 20;
global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;

//Bonus values
global.give_bonus_shines = true;
var names = variable_struct_get_names(global.bonus_shines);

for (var i = 0; i < array_length(names); i++) {
	global.bonus_shines[$ names[i]].reset_scores();
}

for (var i = 0; i < global.player_max; i++) {
	global.bonus_shines_ready[i] = false;
}

//Minigame values
minigame_info_reset();
global.minigame_history = [];

tell_choices = false;

alarm[11] = 1;

//Baba Is Board
tile_image_speed = 0.12;
tile_image_index = 0;
