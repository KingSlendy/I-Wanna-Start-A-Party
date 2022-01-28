depth = -10000;

with (objPlayerBase) {
	change_to_object(objPlayerBoard);
}

global.board_started = false;
global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choice_selected = -1;

global.max_board_turns = 20;
global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;

tell_choices = false;

//Temp
temp = false;
//Temp

alarm[0] = 1;