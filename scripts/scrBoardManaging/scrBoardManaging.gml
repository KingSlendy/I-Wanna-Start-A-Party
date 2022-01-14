#macro BOARD_NORMAL (get_player_turn_info().item_effect != ItemType.Reverse)

enum SpaceType {
	Blue,
	Red,
	Green,
	Shop,
	Blackhole,
	Battle,
	Duel,
	Chancetime,
	TheGuy,
	Shine,
	EvilShine,
	PathChange
}

global.shine_price = 20;
global.min_shop_coins = 5;
global.min_blackhole_coins = 5;

randomize();

function PlayerBoard(network_id, name, turn) constructor {
	self.network_id = network_id;
	self.name = name;
	self.turn = turn;
	//self.shines = 1;
	//self.coins = 100;
	self.shines = 0;
	self.coins = 10;
	self.items = array_create(3, null);
	self.score = 0;
	self.place = 1;
	self.space = c_gray;
	self.item_used = false;
	self.item_effect = null;
	
	static free_item_slot = function() {
		for (var i = 0; i < 3; i++) {
			if (self.items[i] == null) {
				return i;
			}
		}
		
		return -1;
	}
	
	static has_item_slot = function() {
		return (array_count(self.items, null) < 3);
	}
	
	static toString = function() {
		return string(self.turn);
	}
}

function is_player_turn(id = global.player_id) {
	return (global.player_turn == id);
}

function focused_player_turn() {
	with (objPlayerBase) {
		if (network_id == global.player_turn) {
			return id;
		}
	}
	
	with (objNetworkPlayer) {
		if (network_id == global.player_turn) {
			return id;
		}
	}
	
	return null;
}

function focus_player(player_id = global.player_id) {
	with (objPlayerBase) {
		if (network_id == player_id) {
			return id;
		}
	}

	with (objNetworkPlayer) {
		if (network_id == player_id) {
			return id;
		}
	}
	
	return null;
}

function focus_player_turn(turn = global.player_turn) {
	return focus_player(get_player_turn_info(turn).network_id);
}

function get_player_info(player_id = global.player_id) {
	with (objPlayerInfo) {
		if (player_info.network_id == player_id) {
			return player_info;
		}
	}
}

function get_player_turn_info(turn = global.player_turn) {
	with (objPlayerInfo) {
		if (player_info.turn == turn) {
			return player_info;
		}
	}
}

function switch_camera_target(x, y) {
	var s = instance_create_layer(0, 0, "Managers", objSwitchCameraTarget);
	s.switch_x = x;
	s.switch_y = y;
	return s;
}

function board_start() {
	instance_destroy(objHiddenChest);
	
	if (is_player_turn()) {
		if (!global.board_started) {
			if (global.player_id == 1) {
				choose_shine();
			} else {
				board_advance();
			}
		} else {
			turn_start();
		}
	}
}

function turn_start() {
	if (get_player_turn_info().item_effect == ItemType.Ice) {
		turn_next();
		return;
	}
	
	instance_create_layer(0, 0, "Managers", objTurnChoices);
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartTurn);
		network_send_tcp_packet();
	}
}

function turn_next() {
	var player_turn_info = get_player_turn_info();
	player_turn_info.item_used = false;
	player_turn_info.item_effect = null;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.NextTurn);
		network_send_tcp_packet();
	}
	
	global.player_turn += 1;

	if (global.player_turn > 3) {
		global.player_turn = 1;
	}

	with (objCamera) {
		event_perform(ev_step, ev_step_begin);
	}
	
	instance_create_layer(0, 0, "Managers", objNextTurn);
	instance_destroy(objHiddenChest);
}

function board_advance() {
	if (!is_player_turn() || (global.board_started && global.dice_roll == 0)) {
		return;
	}
	
	global.can_open_map = false;
	
	with (objPlayerBoard) {
		follow_path = path_add();
		path_add_point(follow_path, x, y, 100);
		var space = instance_place(x, y, objSpaces);
		var next_space;
		
		if (BOARD_NORMAL) {
			next_space = space.space_next;
		} else {
			next_space = space.space_previous;
		}
		
		path_add_point(follow_path, next_space.x + 16, next_space.y + 16, 100);	
		image_xscale = (next_space.x + 16 >= x) ? 1 : -1;
		path_set_closed(follow_path, false);
		path_start(follow_path, max_speed, path_action_stop, true);
	}
}

function show_dice(id = global.player_id) {
	var focus = focused_player_turn();
	instance_create_layer(focus.x, focus.y - 37, "Actors", objDice);
	
	if (id == global.player_id) {
		objPlayerBoard.can_jump = true;
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowDice);
		buffer_write_data(buffer_u8, id);
		buffer_write_data(buffer_u16, random_get_seed());
		network_send_tcp_packet();
	}
}

function hide_dice() {
	with (objDice) {
		objPlayerBoard.can_jump = false;
		layer_sequence_headpos(sequence, layer_sequence_get_length(sequence));
		layer_sequence_headdir(sequence, -1);
		layer_sequence_play(sequence);
	
		if (is_player_turn()) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.HideDice);
			network_send_tcp_packet();
		}
	}
}

function roll_dice() {
	instance_destroy(objTurnChoices);
	
	var r = instance_create_layer(objDice.x, objDice.y - 16, "Actors", objDiceRoll);
	r.roll = objDice.roll;
	instance_destroy(objDice);
	audio_play_sound(sndDiceHit, 0, false);
	
	var player_turn_info = get_player_turn_info();
	var rolled_all_die = false;
	
	switch (player_turn_info.item_effect) {
		case ItemType.Dice:
			switch (instance_number(objDiceRoll)) {
				case 1:
					r.hspeed = -2;
					break;
				
				case 2:
					r.hspeed = 2;
					rolled_all_die = true;
					break;
			}
			break;
			
		case ItemType.DoubleDice:
			switch (instance_number(objDiceRoll)) {
				case 1:
					r.hspeed = -2;
					break;
					
				case 2:
					r.hspeed = 2;
					break;
				
				case 3:
					rolled_all_die = true;
					break;
			}
			break;
			
		default: rolled_all_die = true; break;
	}
	
	
	if (rolled_all_die) {
		objDiceRoll.target_x = focused_player_turn().x;
	}
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.RollDice);
		buffer_write_data(buffer_u8, r.roll);
		network_send_tcp_packet();
	}
}

function show_chest() {
	var focus = focused_player_turn();
	instance_create_layer(focus.x - 16, focus.y - 75, "Actors", objHiddenChest);
	audio_play_sound(sndHiddenChestSpawn, 0, false);
	
	if (is_player_turn()) {
		objPlayerBoard.can_jump = true;
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowChest);
		network_send_tcp_packet();
	}
}

function open_chest() {
	objHiddenChest.image_speed = 1;
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.OpenChest);
	network_send_tcp_packet();
}

function choose_shine() {
	if (instance_exists(objShine)) {
		return;
	}
	
	var choices = [];
	
	with (objSpaces) {
		if (space_shine) {
			array_push(choices, id);
		}
	}
	
	array_shuffle(choices);
	var space = array_pop(choices);
	space.image_index = SpaceType.Shine;
	place_shine(space.x, space.y);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ChooseShine);
	buffer_write_data(buffer_s16, space.x);
	buffer_write_data(buffer_s16, space.y);
	network_send_tcp_packet();
}

function place_shine(space_x, space_y) {
	with (objSpaces) {
		if (space_shine) {
			image_index = SpaceType.Blue;
		}
	}
			
	with (objSpaces) {
		if (x == space_x && y == space_y) {
			image_index = SpaceType.Shine;
			break;
		}
	}
	
	var c = instance_create_layer(0, 0, "Managers", objChooseShine);
	c.space_x = space_x;
	c.space_y = space_y;
}

function change_shines(amount, type) {
	var s = instance_create_layer(0, 0, "Managers", objShineChange);
	s.amount = amount;
	s.animation_type = type;

	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeShines);
		buffer_write_data(buffer_s16, amount);
		buffer_write_data(buffer_u8, type);
		network_send_tcp_packet();
	}
	
	return s;
}

function change_coins(amount, type) {
	var c = instance_create_layer(0, 0, "Managers", objCoinChange);
	c.amount = amount;
	c.animation_type = type;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeCoins);
		buffer_write_data(buffer_s16, amount);
		buffer_write_data(buffer_u8, type);
		network_send_tcp_packet();
	}
	
	return c;
}

function change_items(item, type) {
	var i = instance_create_layer(0, 0, "Managers", objItemChange);
	i.animation_type = type;
	i.amount = (type == ItemChangeType.Gain) ? 1 : -1;
	i.item = item;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeItems);
		buffer_write_data(buffer_u8, item.id);
		buffer_write_data(buffer_u8, type);
		network_send_tcp_packet();
	}
	
	return i;
}

function calculate_player_place() {
	var scores = array_create(4, 0);
	
	for (var i = 1; i <= 4; i++) {
		var player_info = get_player_info(i);
		scores[i - 1] = player_info.shines * 1000 + player_info.coins;
		player_info.score = scores[i - 1];
		player_info.place = 0;
	}
	
	var swaps = 1;
	
	while (swaps > 0) {
		swaps = 0;
		
		for (var i = 0; i < 3; i++) {
			if (scores[i] < scores[i + 1]) {
				var temp = scores[i + 1];
				scores[i + 1] = scores[i];
				scores[i] = temp;
				swaps++;
			}
		}
	}
	
	for (var i = 1; i <= 4; i++) {
		for (var j = 1; j <= 4; j++) {
			var player_info = get_player_info(j);
			
			if (player_info.place == 0 && player_info.score == scores[i - 1]) {
				player_info.place = i;
			}
		}
	}
}

function change_space(space) {
	var color = c_white;
	
	switch (space) {
		case SpaceType.Blue: color = c_blue; break;
		case SpaceType.Red: color = c_red; break;
		case SpaceType.Green: color = c_green; break;
		default: color = c_gray; break;
	}
	
	get_player_turn_info().space = color;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeSpace);
		buffer_write_data(buffer_u8, space);
		network_send_tcp_packet();
	}
}

function call_shop() {
	var player_turn_info = get_player_turn_info();
			
	if (player_turn_info.free_item_slot() != -1) {
		if (player_turn_info.coins >= global.min_shop_coins) {
			start_dialogue([
				new Message("Do you wanna enter the shop?", [
					["Yes", [
						new Message("",, function() {
							instance_create_layer(0, 0, "Managers", objShop);
							objDialogue.endable = false;
						})
					]],
						
					["No", [
						new Message("",, board_advance)
					]]
				])
			]);
		} else {
			start_dialogue([
				new Message("You don't have enough money to enter the shop!",, board_advance)
			]);
		}
	} else {
		start_dialogue([
			new Message("You don't have item space!\nCome back later.",, board_advance)
		]);
	}
}

function call_blackhole() {
	var player_turn_info = get_player_turn_info();
	
	//if (player_turn_info.free_item_slot() != -1) {
		if (player_turn_info.coins >= global.min_blackhole_coins) {
			start_dialogue([
				new Message("Do you wanna use the blackhole?", [
					["Yes", [
						new Message("",, function() {
							instance_create_layer(0, 0, "Managers", objBlackhole);
							objDialogue.endable = false;
						})
					]],
						
					["No", [
						new Message("",, board_advance)
					]]
				])
			]);
		} else {
			start_dialogue([
				new Message("You don't have enough money!",, board_advance)
			]);
		}
	//} else {
		//start_dialogue([
		//	new Message("You don't have item space!\nCome back later.",, board_advance)
		//]);
	//}
}

function show_multiple_choices(titles, choices, descriptions, availables) {
	global.choice_selected = -1;
	var m = instance_create_layer(0, 0, "Managers", objMultipleChoices);
	m.titles = titles;
	m.choices = choices;
	m.descriptions = descriptions;
	m.availables = availables;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowMultipleChoices);
		buffer_write_array(buffer_string, titles);
		buffer_write_array(buffer_string, choices);
		buffer_write_array(buffer_string, descriptions);
		buffer_write_array(buffer_bool, availables);
		network_send_tcp_packet();
	}
	
	return m;
}

function item_applied(item) {
	var player_turn_info = get_player_turn_info();
	
	switch (item.id) {
		case ItemType.Dice:
		case ItemType.DoubleDice:
		case ItemType.Clock:
		case ItemType.Poison:
		case ItemType.Reverse:
			player_turn_info.item_effect = item.id;
			break;
	}
	
	if (is_player_turn()) {
		switch (item.id) {
			case ItemType.Ice:
				show_multiple_player_choices(function(i) {
					return get_player_turn_info(i).item_effect == null;
				}, true).final_action = function() {
					item_animation(ItemType.Ice);
				}
				break;
			
			case ItemType.Warp:
				show_multiple_player_choices(function(_) { return true; }, true).final_action = function() {
					item_animation(ItemType.Warp);
				}
				break;
			
			case ItemType.Cellphone:
				call_shop();
				break;
			
			case ItemType.Blackhole:
				call_blackhole();
				break;
			
			case ItemType.Mirror:
				item_animation(ItemType.Mirror);
				break;
		}
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemApplied);
		buffer_write_data(buffer_u8, item.id);
		network_send_tcp_packet();
	}
}

function item_animation(item_id, additional = noone) {
	var item = global.board_items[item_id];
	var i = instance_create_layer(0, 0, "Managers", item.animation);
	i.sprite = item.sprite;
	i.additional = additional;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemAnimation);
		buffer_write_data(buffer_u8, item_id);
		buffer_write_data(buffer_s8, additional);
		network_send_tcp_packet();
	}
	
	return i;
}

function show_multiple_player_choices(available_func, not_me = false) {
	return show_multiple_choices(all_player_names(not_me), all_player_choices(not_me), [], all_player_availables(available_func, not_me));
}

function all_player_names(not_me = false) {
	var names = [];
			
	for (var i = 1; i <= 4; i++) {
		var player = get_player_turn_info(i);
		
		if (i == player_turn_info.turn && not_me) {
			player = null;
		}
				
		if (player != null) {
			array_push(names, player_turn_info.name);
		} else {
			array_push(names, "");
		}
	}
		
	return names;
}

function all_player_choices(not_me = false) {
	var choices = [];
			
	for (var i = 1; i <= 4; i++) {
		var player = focus_player_turn(i);
		
		if (i == player_turn_info.turn && not_me) {
			player = null;
		}
				
		if (player != null) {
			array_push(choices, "{SPRITE," + sprite_get_name(get_skin_pose_object(player, "Idle")) + ",0,-48,-64,3,3}");
		} else {
			array_push(choices, "");
		}
	}
		
	return choices;
}

function all_player_availables(func, not_me = false) {
	var availables = [];
			
	for (var i = 1; i <= 4; i++) {
		var player = focus_player_turn(i);
		
		if (i == player_turn_info.turn && not_me) {
			player = null;
		}
				
		if (player != null) {
			array_push(availables, func(i));
		} else {
			array_push(availables, false);
		}
	}
		
	return availables;
}