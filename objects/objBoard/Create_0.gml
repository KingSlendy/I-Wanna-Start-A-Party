depth = -10000;

with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

global.initial_rolls = array_sequence(1, 10);
array_shuffle(global.initial_rolls);
array_delete(global.initial_rolls, global.player_max, array_length(global.initial_rolls) - global.player_max);

//Board controllers
global.board_started = false;
global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choice_selected = -1;

global.minigame_info = {
	reference: global.minigames[$ "2vs2"][0],
	type: "",
	player_colors: [],
	is_practice: false,
	players_won: []
};

//Board values
global.max_board_turns = 20;
global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;

tell_choices = false;

//Temp
temp = false;
//Temp

alarm[0] = 1;