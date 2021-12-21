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
	self.coins = 10;
	self.items = array_create(3, null);
	self.score = 0;
	self.place = 1;
	self.space = c_gray;
	
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
}

function focus_player(id) {
	if (id == global.player_id) {
		return objPlayerBase;
	} else {
		with (objNetworkPlayer) {
			if (network_id == id) {
				return id;
			}
		}
	}
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
	instance_create_layer(0, 0, "Managers", objChoices);
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.StartTurn);
		network_send_tcp_packet();
	}
}

function board_advance() {
	if (!is_player_turn()) {
		return;
	}
	
	with (objPlayerBoard) {
		follow_path = path_add();
		var path_total = path_get_number(global.path_current);
		var current_x = path_get_point_x(global.path_current, global.path_number);
		var current_y = path_get_point_y(global.path_current, global.path_number);
		var next_x, next_y;
		path_add_point(follow_path, current_x, current_y, 100);
	
		if (global.path_direction == 1) {
			next_x = path_get_point_x(global.path_current, global.path_number + global.path_direction);
			next_y = path_get_point_y(global.path_current, global.path_number + global.path_direction);
			path_add_point(follow_path, next_x, next_y, 100);	
			array_push(space_stack, {
				prev_path: global.path_current,
				prev_number: global.path_number,
				prev_x: current_x,
				prev_y: current_y
			});
		
			if (array_length(space_stack) > 10) {
				array_delete(space_stack, 0, 1);
			}
		
			global.path_number = (global.path_number + global.path_direction + path_total) % path_total;
		} else if (global.path_direction == -1) {
			var reverse = array_pop(space_stack);
			next_x = reverse.prev_x;
			next_y = reverse.prev_y;
			path_add_point(follow_path, reverse.prev_x, reverse.prev_y, 100);
			global.path_current = reverse.prev_path;
			global.path_number = reverse.prev_number;
		}

		image_xscale = (next_x >= current_x) ? 1 : -1;
		path_set_closed(follow_path, false);
		path_start(follow_path, max_speed, path_action_stop, true);
	}
}

function show_dice(id = global.player_id) {
	var focus = focused_player_turn();
	instance_create_layer(focus.x - 16, focus.y - 69, "Actors", objDice);
	
	if (id == global.player_id) {
		objPlayerBoard.can_jump = true;
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ShowDice);
		buffer_write_data(buffer_u8, id);
		network_send_tcp_packet();
	}
}

function roll_dice() {
	instance_destroy(objChoices);
	
	instance_create_layer(objDice.x + 16, objDice.y + 16, "Actors", objDiceRoll);
	audio_play_sound(sndDiceHit, 0, false);
	//global.dice_roll = objDice.roll;
	global.dice_roll = 10;
	instance_destroy(objDice);
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.RollDice);
		buffer_write_data(buffer_u8, global.dice_roll);
		network_send_tcp_packet();
	}
}

function show_chest(id = global.player_id) {
	var focus = focused_player_turn();
	var c = instance_create_layer(focus.x - 16, focus.y - 75, "Actors", objHiddenChest);
	c.player_id = id;
	audio_play_sound(sndHiddenChestSpawn, 0, false);
	
	if (id == global.player_id) {
		objPlayerBoard.can_jump = true;
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ShowChest);
		buffer_write_data(buffer_u8, id);
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
	global.player_turn += 1;
	
	if (global.player_turn > 1) {
		global.player_turn = 1;
	}
	
	instance_create_layer(0, 0, "Managers", objNextTurn);
	instance_destroy(objHiddenChest);
	
	buffer_seek_begin();
	buffer_write_from_host(false);
	buffer_write_action(Client_TCP.NextTurn);
	buffer_write_data(buffer_u8, global.player_turn);
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

function change_shines(amount, type, id = global.player_id) {
	var s = instance_create_layer(0, 0, "Managers", objShineChange);
	s.player_id = id;
	s.amount = amount;
	s.animation_type = type;

	if (id == global.player_id) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeShines);
		buffer_write_data(buffer_u8, id);
		buffer_write_data(buffer_u8, amount);
		buffer_write_data(buffer_u8, type);
		network_send_tcp_packet();
	}
	
	return s;
}

function change_coins(amount, type, id = global.player_id) {
	var c = instance_create_layer(0, 0, "Managers", objCoinChange);
	c.player_id = id;
	c.amount = amount;
	c.animation_type = type;
	
	if (id == global.player_id) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeCoins);
		buffer_write_data(buffer_u8, id);
		buffer_write_data(buffer_s16, amount);
		buffer_write_data(buffer_u8, type);
		network_send_tcp_packet();
	}
	
	return c;
}

function change_items(item, type, id = global.player_id) {
	var i = instance_create_layer(0, 0, "Managers", objItemChange);
	i.player_id = id;
	i.animation_type = type;
	i.amount = (type == ItemChangeType.Gain) ? 1 : -1;
	i.item = item;
	
	if (id == global.player_id) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeItems);
		buffer_write_data(buffer_u8, id);
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

function change_space(space, id = global.player_id) {
	var color = c_white;
	
	switch (space) {
		case SpaceType.Blue: color = c_blue; break;
		case SpaceType.Red: color = c_red; break;
		case SpaceType.Green: color = c_green; break;
		default: color = c_gray; break;
	}
	
	get_player_info(id).space = color;
	
	if (id == global.player_id) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.ChangeSpace);
		buffer_write_data(buffer_u8, id);
		buffer_write_data(buffer_u8, space);
		network_send_tcp_packet();
	}
}