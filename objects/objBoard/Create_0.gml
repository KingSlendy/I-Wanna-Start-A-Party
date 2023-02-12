if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}

fade_start = true;
fade_alpha = 1;

//Board controllers
global.board_started = false;
global.board_turn = 1;
global.player_turn = 1;
global.dice_roll = 0;
global.choice_selected = -1;
global.item_choice = false;
global.buy_choice = -1;

//Board values
global.shine_spawn_count = 1;
global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;
global.max_blackhole_coins = 50;

//Bonus values
for (var i = 0; i < array_length(global.bonus_shines); i++) {
	global.bonus_shines[i].reset_scores();
}

for (var i = 0; i < global.player_max; i++) {
	global.bonus_shines_ready[i] = false;
}

//Minigame values
minigame_info_reset();
global.minigame_history = [];
global.minigame_type_history = [];

tell_choices = false;
cpu_wait = true;
cpu_staled = true;
cpu_performed = true;
cpu_item = -1;

//Island Board
global.board_day = true;

//Baba Board
global.baba_blocks = array_create(3, 0);
global.baba_toggled = array_create(3, false);
block_sprites = [];
var colors = ["Yellow", "Blue", "Pink"];
var types = ["Double", "Half", "Free"];

for (var i = 0; i < array_length(global.baba_blocks); i++) {
	var blocks = [];
	
	for (var j = 0; j < array_length(global.baba_blocks); j++) {
		array_push(blocks, asset_get_index(string("sprBoardBabaBlock{0}{1}", types[j], colors[i])));
	}
	
	array_push(block_sprites, blocks);
}

tile_image_speed = 0.12;
tile_image_index = 0;

//Pallet Board
global.pokemon_price = 15;

//Hyrule Board
global.board_light = true;
global.board_dark_chance = 0;
prev_board_light = !global.board_light;

//Nsanity Board
layer_back_name = "Background";
layer_back_id = layer_background_get_id(layer_back_name);

alarms_init(12);

alarm_create(function() {
	event_perform(ev_other, ev_room_start);
});

alarm_create(function() {
	for (var i = 0; i < array_length(global.minigame_info.players_won); i++) {
		var player_won = global.minigame_info.players_won[i];
		change_coins(10, CoinChangeType.Gain, player_info_by_id(player_won).turn);
	}

	alarm_call(2, 3.3);
});

alarm_create(function() {
	minigame_info_placement();

	for (var i = 0; i < global.player_max; i++) {
		var player_info = places_minigame_info[i];
		var order = places_minigame_order[i];
			
		with (player_info) {
			target_draw_x = 400 - draw_w / 2;
			target_draw_y = 79 + (draw_h + 30) * (order - 1);
		}
	}

	alarm_call(3, 1.5);
});

alarm_create(function() {});

alarm_create(function() {
	turn_next(false);
});

//World Board
alarm_create(function() {
	next_seed_inline();
	show_dice(focused_player().network_id);
	alarm_frames(6, irandom_range(25, 75));
});

alarm_create(function() {
	with (focused_player()) {
		board_jump();
	}
});

alarm_create(function() {
	instance_create_layer(0, 0, "Managers", objBoardWorldShuffle);
});

alarm_create(11, function() {
	if (global.player_id != 1) {
		return;
	}

	cpu_staled = false;
	cpu_performed = false;
	alarm_frames(11, 1);

	var stale_action = function(seconds) {
		if (!cpu_wait || cpu_staled || cpu_performed) {
			return;
		}
	
		alarm_call(11, seconds);
		cpu_wait = false;
		cpu_staled = true;
	}

	var perform_action = function(action) {
		if (cpu_staled || cpu_performed) {
			return;
		}
	
		action.press();
		cpu_wait = true;
		cpu_performed = true;
	}

	var stale_frames = random_range(0.1, 0.3);

	if (global.board_started &&  is_player_turn()) {
		var player_info = player_info_by_turn();
		var actions = check_player_actions_by_id(player_info.network_id);

		if (actions == null) {
			exit;
		}
	
		if (instance_exists(objTurnChoices) && objTurnChoices.can_choose()) {
			if (player_info.item_used != null) {
				cpu_item = -1;
			}
		
			if (cpu_item == -1 && player_info.item_used == null && array_count(player_info.items, null) < 3) {
				var use_percentage = array_create(3, 0);
				
				for (var i = 0; i < 3; i++) {
					var item = player_info.items[i];
			
					if (item == null || !item.use_criteria()) {
						continue;
					}
				
					use_percentage[i] = irandom_range(0, 100);
				}
			
				if (array_count(use_percentage, 0) < 3) {
					var max_percentage = -infinity;
			
					for (var i = 0; i < 3; i++) {
						max_percentage = max(max_percentage, use_percentage[i]);
					}
				
					var most_percentage = [];
				
					for (var i = 0; i < 3; i++) {
						if (use_percentage[i] == max_percentage) {
							array_push(most_percentage, i);
						}
					}
				
					array_shuffle_ext(most_percentage);
					var chosen_percentage = most_percentage[0];
					cpu_item = chosen_percentage;
				}
			}
		
			if (cpu_item == -1) {
				stale_action(stale_frames);
			
				if (objTurnChoices.option_selected == 0) {
					perform_action(actions.jump);
				} else {
					perform_action(actions.up);
				}
			} else {
				stale_action(stale_frames);
			
				if (objTurnChoices.option_selected == 0) {
					perform_action(actions.down);
				} else {
					perform_action(actions.jump);
				}
			}
		}
	
		if (instance_exists(objMultipleChoices)) {
			stale_action(stale_frames);
		
			if (global.item_choice) {
				if (global.choice_selected == cpu_item) {
					perform_action(actions.jump);
				} else {
					perform_action(actions.right);
				}
			}
		}
	
		if (instance_exists(objBox)) {
			var stale = random_range(0.5, 1.5);
			
			if (instance_exists(objDice) && player_info_by_turn().item_effect == ItemType.Clock) {
				stale = random_range(3, 5);
			}
			
			stale_action(stale);
			perform_action(actions.jump);
		}
	
		if (instance_exists(objPathChange)) {
			if (0.3 > random(1)) {
				perform_action(choose(actions.left, actions.up, actions.down, actions.right));
			}
			
			perform_action(actions.jump);
		}
		
		if (instance_exists(objShop) && objShop.shopping) {
			stale_action(random_range(0.5, 1));
			
			if (global.buy_choice == -1) {
				perform_action(actions.shoot);
			}
			
			if (objShop.option_selected != global.buy_choice) {
				perform_action(actions.down);
			}
			
			perform_action(actions.jump);
		}
		
		if (instance_exists(objBlackhole)) {
			if (player_info_by_turn().coins >= global.max_blackhole_coins && objBlackhole.option_selected != 1) {
				perform_action(actions.down);
			} else {
				perform_action(actions.jump);
			}
			
			perform_action(actions.jump);
		}
	
		if (instance_exists(objDialogue)) {
			if (room == rBoardPallet) {
				var space = instance_place(x, y, objSpaces);
				
				if (space != noone && space.image_index == SpaceType.PathEvent && player_info_by_turn().pokemon != -1 && array_length(objDialogue.answer_displays) > 0 && objDialogue.answer_index == 0 && 0.75 > random(1)) {
					stale_action(1);
					perform_action(actions.down);
				}
			}
			
			stale_action(0.1);
			perform_action(actions.jump);
		}

		var keys = variable_struct_get_names(actions);
		perform_action(actions[$ keys[irandom(array_length(keys) - 1)]]);
	} else if (!instance_exists(objDialogue)) {
		for (var i = 2; i <= global.player_max; i++) {
			var actions = check_player_actions_by_id(i);
		
			if (actions == null) {
				continue;
			}
		
			actions.jump.press();
		}
	}
});

alarm_frames(11, 1);