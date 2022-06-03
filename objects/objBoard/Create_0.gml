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

if (!global.load_board) {
	global.game_id = date_datetime_string(date_current_datetime()) + " " + string(get_timer()) + " " + string(irandom(9999999));
}

global.seed_bag = [];

repeat (120) {
	array_push(global.seed_bag, irandom(9999999));
}

global.current_seed = -1;
global.initial_rolls = array_sequence(1, 10);
array_shuffle(global.initial_rolls);
array_delete(global.initial_rolls, global.player_max, array_length(global.initial_rolls) - global.player_max);

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

if (global.load_board) {
	global.board_started = true;
	var board = global.board_games[$ global.game_id];
	global.max_board_turns = board.saved_board.saved_max_turns;
	global.board_turn = board.saved_board.saved_turn;
	global.board_first_space = board.saved_board.saved_first_space;
	
	with (instance_create_layer(board.saved_board.saved_shine_position[0], board.saved_board.saved_shine_position[1], "Actors", objShine)) {
		image_xscale = 1;
		image_yscale = 1;
		spawning = false;
		floating = true;
	}
	
	for (var i = 0; i < array_length(board.saved_board.saved_spaces); i++) {
		var space = board.saved_board.saved_spaces[i];
	
		with (objSpaces) {
			if (x == space[0] && y == space[1]) {
				image_index = space[2];
				break;
			}
		}
	}
	
	var names = variable_struct_get_names(board.saved_players);
	
	for (var i = 0; i < array_length(names); i++) {
		for (var j = 1; j <= global.player_max; j++) {
			var player = focus_player_by_id(j);
			
			if (player.network_name == names[i]) {
				var saved_player = board.saved_players[$ names[i]];
				spawn_player_info(j, saved_player.saved_turn);
				var player_info = focus_info_by_id(j);
				player_info.shines = saved_player.saved_shines;
				player_info.coins = saved_player.saved_coins;
				player_info.items = saved_player.items;
				player_info.place = saved_player.place;
				player_info.item_effect = saved_player.item_effect;
				player.x = saved_player.saved_position[0];
				player.y = saved_player.saved_position[1];
				break;
			}
		}
	}
}

//Minigame values
minigame_info_reset();

tell_choices = false;

alarm[11] = 1;

//Baba Is Board
tile_image_speed = 0.12;
tile_image_index = 0;
