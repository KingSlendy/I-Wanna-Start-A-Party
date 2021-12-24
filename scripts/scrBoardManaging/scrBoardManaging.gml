enum SpaceType {
	Blue,
	Red,
	Green,
	Pink,
	Purple,
	Orange,
	Yellow,
	Dark,
	Cyan,
	Shine,
	EvilShine,
	PathChange
}

randomize();

function PlayerBoard(network_id, turn) constructor {
	self.network_id = network_id;
	self.turn = turn;
	self.shines = 0;
	self.coins = 100;
	self.items = array_create(3, null);
	self.score = 0;
	self.place = 1;
	self.space = c_gray;
	self.item_used = false;
	self.item_effect = null;
	
	static free_item_slot = function() {
		if (self.items[2]) {
			return -1;
		}
		
		var slot = 0;
		
		while (slot < 2 && self.items[slot] != null) {
			slot++;
		}
		
		return slot;
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
	if (is_player_turn()) {
		return objPlayerBase;
	} else {
		with (objNetworkPlayer) {
			if (network_id == global.player_turn) {
				return id;
			}
		}
	}
	
	return null;
}

function focus_player(player_id = global.player_id) {
	if (player_id == global.player_id) {
		return objPlayerBase;
	} else {
		with (objNetworkPlayer) {
			if (network_id == player_id) {
				return id;
			}
		}
	}
	
	return null;
}

function focus_player_turn(turn = global.player_turn) {
	return focus_player(get_player_turn_info(turn).network_id);
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
	instance_create_layer(0, 0, "Managers", objTurnChoices);
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.StartTurn);
		buffer_write_data(buffer_u8, id);
		network_send_tcp_packet();
	}
}

function board_advance() {
	if (!is_player_turn() || (global.board_started && global.dice_roll == 0)) {
		return;
	}
	
	global.can_open_map = false;
	
	with (objPlayerBoard) {
		follow_path = path_add();
		var next_x, next_y;
		path_add_point(follow_path, x, y, 100);
		var space = instance_place(x, y, objSpaces);
	
		if (global.path_direction == 1) {
			next_x = space.space_next.x + 16;
			next_y = space.space_next.y + 16;
			path_add_point(follow_path, next_x, next_y, 100);	
		} else if (global.path_direction == -1) {
			next_x = space.space_previous.y + 16;
			next_y = space.space_previous.y + 16;
		}
		
		path_add_point(follow_path, next_x, next_y, 100);	
		image_xscale = (next_x >= x) ? 1 : -1;
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ShowDice);
		buffer_write_data(buffer_u8, id);
		buffer_write_data(buffer_u16, random_get_seed());
		network_send_tcp_packet();
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.RollDice);
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ShowChest);
		network_send_tcp_packet();
	}
}

function open_chest() {
	objHiddenChest.image_speed = 1;
	
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.OpenChest);
	network_send_tcp_packet();
}

function next_turn() {
	var player_turn_info = get_player_turn_info();
	player_turn_info.item_used = false;
	player_turn_info.item_effect = null;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.NextTurn);
		network_send_tcp_packet();
	}
	
	global.player_turn += 1;

	if (global.player_turn > 1) {
		global.player_turn = 1;
	}

	instance_create_layer(0, 0, "Managers", objNextTurn);
	instance_destroy(objHiddenChest);
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
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.ChooseShine);
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

function get_player_info(id = global.player_id) {
	with (objPlayerInfo) {
		if (player_info.network_id == id) {
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

function change_shines(amount, type) {
	var s = instance_create_layer(0, 0, "Managers", objShineChange);
	s.amount = amount;
	s.animation_type = type;

	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeShines);
		buffer_write_data(buffer_u8, amount);
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeCoins);
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeItems);
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
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeSpace);
		buffer_write_data(buffer_u8, space);
		network_send_tcp_packet();
	}
}

function call_shop() {
	var player_turn_info = get_player_turn_info();
			
	if (player_turn_info.free_item_slot() != -1) {
		if (player_turn_info.coins >= 5) {
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

function show_multiple_choices(choices) {
	global.choice_selected = -1;
	var m = instance_create_layer(0, 0, "Managers", objMultipleChoices);
	m.choices = choices;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ShowMultipleChoices);
		
		for (var i = 0; i < array_length(choices); i++) {
			buffer_write_data(buffer_string, choices[i]);
		}
		
		buffer_write_data(buffer_string, "EOF");
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
			player_turn_info.item_effect = item.id;
			break;
	}
	
	if (is_player_turn()) {
		switch (item.id) {
			case ItemType.Warp:
				show_multiple_choices(all_player_choices(true)).final_action = function() {
					item_use(ItemType.Warp);
				}
				break;
			
			case ItemType.Cellphone:
				call_shop();
				break;
			
			case ItemType.Mirror:
				item_use(ItemType.Mirror);
				break;
		}
		
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ItemApplied);
		buffer_write_data(buffer_u8, item.id);
		network_send_tcp_packet();
	}
}

function item_use(item) {
	var objects = {};
	objects[$ ItemType.Warp] = objItemWarpUsed;
	objects[$ ItemType.Mirror] = objItemMirrorUsed;
	instance_create_layer(0, 0, "Managers", objects[$ item]);
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