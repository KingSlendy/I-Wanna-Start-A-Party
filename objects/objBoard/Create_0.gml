if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

depth = -10000;

fade_start = true;
fade_alpha = 1;

with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

global.seed_bag = [];

repeat (100) {
	array_push(global.seed_bag, irandom(9999999));
}

global.current_seed = -1;
global.initial_rolls = array_sequence(1, 10);
array_shuffle(global.initial_rolls);
array_delete(global.initial_rolls, global.player_max, array_length(global.initial_rolls) - global.player_max);

//Board controllers
global.board_started = false;
global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choice_selected = -1;

//Board values
global.max_board_turns = 1;
global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;

//Bonus values
global.bonuses = {};
var names = variable_struct_get_names(global.bonuses);

for (var i = 0; i < array_length(names); i++) {
	global.bonuses[$ names[i]] = array_create(global.player_max, 0);
}

//Minigame values
minigame_info_reset();

tell_choices = false;

alarm[11] = 1;
