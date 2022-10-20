#region Initialization Management
#macro BOARD_NORMAL (player_info_by_turn().item_effect != ItemType.Reverse)

enum SpaceType {
	Blue,
	Red,
	Green,
	Shop,
	Blackhole,
	Item,
	Warp,
	ChanceTime,
	TheGuy,
	Shine,
	PathEvent,
	PathChange
}

randomize();
#endregion

#region Player Management
function PlayerBoard(network_id, name, turn) constructor {
	self.network_id = network_id;
	self.name = name;
	self.turn = turn;
	self.shines = 0;
	self.coins = 0;
	self.items = array_create(3, null);
	//self.shines = 0;
	//self.coins = 100;
	//self.items = [null, global.board_items[ItemType.TripleDice], global.board_items[ItemType.DoubleDice]];
	self.score = 0;
	self.place = 1;
	self.space = c_ltgray;
	self.item_used = null;
	self.item_effect = null;
	self.pokemon = -1;
	
	static free_item_slot = function() {
		for (var i = 0; i < 3; i++) {
			if (self.items[i] == null) {
				return i;
			}
		}
		
		return array_length(self.items);
	}
	
	static has_item_slot = function() {
		return (array_count(self.items, null) < 3);
	}
	
	static toString = function() {
		return string_interp("ID: {0}\nName: {1}\nTurn: {2}\nShines: {3}\nCoins: {4}\nPlace: {5}", self.network_id, self.name, self.turn, self.shines, self.coins, self.place);
	}
}

function is_local_turn() {
	if (!global.board_started) {
		with (objPlayerBase) {
			if (is_player_local(network_id) && network_id == 1) {
				return true;
			}
		}
		
		return false;
	}
	
	var player_info = player_info_by_turn(global.player_turn);
	
	with (objPlayerBase) {
		if (is_player_local(network_id) && player_info.network_id == network_id) {
			return true;
		}
	}
	
	return false;
}

function is_player_local(player_id = global.player_id) {
	return (focus_player_by_id(player_id).object_index != objNetworkPlayer);
}

function focused_player() {
	if (!global.board_started) {
		with (objPlayerBase) {
			if (network_id == 1) {
				return id;
			}
		}
	}
	
	with (objPlayerBase) {
		var player_info = player_info_by_id(network_id);
		
		if (player_info.turn == global.player_turn) {
			return id;
		}
	}
	
	return null;
}

function focus_player_by_id(player_id = global.player_id) {
	with (objPlayerBase) {
		if (network_id == player_id) {
			return id;
		}
	}
	
	return null;
}

function focus_player_by_turn(turn = global.player_turn) {
	return focus_player_by_id(player_info_by_turn(turn).network_id);
}

function spawn_player_info(order, turn) {
	if (instance_exists(focus_info_by_id(order))) {
		return;
	}
	
	with (objDiceRoll) {
		if (network_id == order) {
			instance_destroy();
			break;
		}
	}
	
	var info = instance_create_layer(0, 0, "Managers", objPlayerInfo);
	info.player_info = new PlayerBoard(order, focus_player_by_id(order).network_name, turn);
	
	with (info) {
		setup();
	}
	
	if (array_length(global.player_game_ids) == 0 && is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.SpawnPlayerInfo);
		buffer_write_data(buffer_u8, order);
		buffer_write_data(buffer_u8, turn);
		network_send_tcp_packet();
	}
}

function player_info_by_id(player_id = global.player_id) {
	with (objPlayerInfo) {
		if (player_info.network_id == player_id) {
			return player_info;
		}
	}
}

function player_info_by_turn(turn = global.player_turn) {
	with (objPlayerInfo) {
		if (player_info.turn == turn) {
			return player_info;
		}
	}
}

function focus_info_by_id(player_id = global.player_id) {
	with (objPlayerInfo) {
		if (player_info.network_id == player_id) {
			return id;
		}
	}
}

function focus_info_by_turn(turn = global.player_turn) {
	with (objPlayerInfo) {
		if (player_info.turn == turn) {
			return id;
		}
	}
}

function store_player_positions() {
	var positions = array_create(global.player_max, null);
	
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		positions[i - 1] = {x: player.x, y: player.y};
	}
	
	return positions;
}

function get_player_count(index) {
	var count = 0;
	
	with (objPlayerBase) {
		if (object_index == index || (!is_player_local(network_id) && network_index == index && network_room == room)) {
			count++;
		}
	}
	
	return count;
}

function get_ai_count() {
	var count = 0;
	
	with (objPlayerBase) {
		if (ai) {
			count++;
		}
	}
	
	return count;
}

function player_color_by_turn(turn) {
	var colors = [c_blue, c_red, c_lime, c_yellow];
	return colors[turn - 1];
}
#endregion

#region Board Management
function switch_camera_target(x, y) {
	var s = instance_create_layer(0, 0, "Managers", objSwitchCameraTarget);
	s.switch_x = x;
	s.switch_y = y;
	
	with (s) {
		snap_camera();
	}
	
	return s;
}

function board_music() {
	var room_name = room_get_name(room);
	var bgm_name = "bgm" + string_copy(room_name, 2, string_length(room_name) - 1);
	
	if (room == rBoardIsland && !global.board_day) {
		bgm_name += "Night";
	}
	
	if (room == rBoardHyrule && !global.board_light) {
		bgm_name += "Dark";
	}
	
	music_play(asset_get_index(bgm_name));
}

function board_start() {
	if (global.board_started) {
		save_board();
		generate_seed_bag();
		
		switch (room) {
			case rBoardIsland:
				if (!global.board_day) {
					next_seed_inline();
					global.shine_price = choose(0, 1, 3, 4) * 10;
				} else {
					global.shine_price = 20;
				}
				break;
		}
	}
	
	if (!is_local_turn()) {
		return;
	}
	
	if (!global.board_started) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardStart);
		buffer_write_data(buffer_string, global.game_id);
		network_send_tcp_packet();
		
		start_dialogue([
			"Welcome!",
			new Message("Let's choose the turns",, choose_turns)
		]);
	} else {
		turn_start();
	}
}

function choose_turns() {
	for (var i = 1; i <= global.player_max; i++) {
		show_dice(i);
	}
}

function tell_turns() {
	turn_rolls = array_create(global.player_max, null);
	
	with (objDiceRoll) {
		other.turn_rolls[network_id - 1] = roll;
	}
	
	turn_rolls_ordered = [];
	array_copy(turn_rolls_ordered, 0, turn_rolls, 0, global.player_max);
	array_sort(turn_rolls_ordered, false);
	turn_names = array_create(global.player_max, null);
	turn_orders = array_create(global.player_max, null);
	
	for (var i = 1; i <= global.player_max; i++) {
		var turn_roll = turn_rolls_ordered[i - 1];
		var turn_id = array_index(turn_rolls, turn_roll) + 1;
		turn_orders[i - 1] = turn_id;
		
		with (objPlayerBase) {
			if (network_id == turn_id) {
				other.turn_names[i - 1] = network_name;
				break;
			}
		}
	}
	
	dialogue_player_info = function(turn) {
		var order = turn_orders[turn - 1];
		spawn_player_info(order, turn);
	}
	
	start_dialogue([
		new Message("The order has been decided!",, function() {
			dialogue_player_info(1);
		}),
		
		new Message(string_interp("{COLOR,0000FF}{0}{COLOR,FFFFFF} goes first!", turn_names[0]),, function() {
			dialogue_player_info(2);
		}),
		
		new Message(string_interp("{COLOR,0000FF}{0}{COLOR,FFFFFF} follows as second!", turn_names[1]),, function() {
			dialogue_player_info(3);
		}),
		
		new Message(string_interp("Then {COLOR,0000FF}{0}{COLOR,FFFFFF} goes third!", turn_names[2]),, function() {
			dialogue_player_info(4);
		}),
		
		string_interp("And last to go is {COLOR,0000FF}{0}{COLOR,FFFFFF}.", turn_names[3]),
		new Message("Let's give each one {COLOR,00FFFF}10{COLOR,FFFFFF} coins to start.",, function() {
			for (var i = 1; i <= global.player_max; i++) {
				var c = change_coins(10, CoinChangeType.Gain, i);
				
				if (i == 1) {
					c.final_action = function() {
						start_dialogue([
							new Message("I wonder where the first shine is gonna be...",, choose_shine)
						]);
					}
				}
			}
		})
	]);
}

function turn_start() {
	global.dice_roll = 0;
	var in_space = true;
	
	with (focused_player()) {
		in_space = place_meeting(x, y, objSpaces);
	}
	
	if (global.board_turn == 1 && !in_space) {
		if (is_local_turn()) {
			global.dice_roll = -1;
			board_advance();
		}
		
		return;
	}
	
	var freezed = (player_info_by_turn().item_effect == ItemType.Ice);
	
	if (freezed) {
		with (objBoard) {
			alarm_call(4, 1);
		}
	}
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.TurnStart);
		network_send_tcp_packet();
	}
	
	if (!freezed && !instance_exists(objTurnChoices)) {
		instance_create_layer(0, 0, "Managers", objTurnChoices);
	}
}

function turn_next(network = true) {
	var player_info = player_info_by_turn();
	player_info.item_used = null;
	player_info.item_effect = null;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.TurnNext);
		network_send_tcp_packet();
	}
	
	if (++global.player_turn > global.player_max) {
		global.player_turn = global.player_max;
		
		if (is_local_turn()) {
			choose_minigame();
		}
		
		return;
	}

	//Focuses the camera on the current player
	with (objCamera) {
		event_perform(ev_step, ev_step_begin);
	}
	
	instance_create_layer(0, 0, "Managers", objNextTurn);
	instance_destroy(objInterface);
	instance_destroy(objDiceRoll);
	instance_destroy(objHiddenChest);
}

function board_advance() {
	if (!is_local_turn() || global.dice_roll == 0) {
		return;
	}

	with (focused_player()) {
		var space = instance_place(x, y, objSpaces);
		var next_space;
		
		if (space != noone) {
			var next_space;
		
			if (BOARD_NORMAL) {
				next_space = space.space_next;
			} else {
				next_space = space.space_previous;
			}
		} else {
			with (objSpaces) {
				if (image_index == 12) {
					next_space = id;
					break;
				}
			}
		}
		
		follow_path = path_add();
		path_add_point(follow_path, x, y, 100);
		path_add_point(follow_path, next_space.x + 16, next_space.y + 16, 100);	
		image_xscale = (next_space.x + 16 >= x) ? 1 : -1;
		path_set_closed(follow_path, false);
		path_start(follow_path, max_speed, path_action_stop, true);
	}
}

function board_path_finding() {
	global.path_spaces = [];
	global.path_spaces_record = infinity;
	objSpaces.visited = false;
	
	with (focused_player()) {
		space_path_finding(instance_place(x, y, objSpaces), []);
	}
}

function space_path_finding(space, path_spaces) {
	var end_finding = function(path_spaces) {
		global.path_spaces_record = array_length(path_spaces);
		array_copy(global.path_spaces, 0, path_spaces, 0, array_length(path_spaces));
	}
	
	array_push(path_spaces, space);
	
	with (space) {
		if (visited || array_length(path_spaces) > global.path_spaces_record) {
			break;
		}
		
		var space_all = (BOARD_NORMAL) ? space_directions_normal : space_directions_reverse;
		visited = true;
		
		if (image_index == SpaceType.PathEvent) {
			global.board_lock_event = true;
			
			switch (room) {
				case rBoardPallet:
					if (instance_nearest(x, y, objBoardPalletPokemon).has_shine()) {
						end_finding(path_spaces);
					}
					break;
					
				case rBoardDreams:
					var teleport = event();
					
					with (teleport) {
						space_all = [instance_place(x, y, objSpaces)];
					}
					break;
			}
			
			global.board_lock_event = false;
		}
		
		if (image_index == SpaceType.Shine) {
			end_finding(path_spaces);
			break;
		}

		for (var i = 0; i < array_length(space_all); i++) {
			var space_check = space_all[i];
				
			if (space_check == null) {
				continue;
			}
				
			space_path_finding(space_check, path_spaces);
		}
		
		visited = false;
	}
	
	array_pop(path_spaces);
}

function choose_minigame() {
	instance_create_layer(0, 0, "Managers", objChooseMinigame);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChooseMinigame);
		network_send_tcp_packet();
	}
}

function board_finish() {
	room_goto(rResults);
}
#endregion

#region Interactable Management
function show_dice(player_id) {
	var focus_player = focus_player_by_id(player_id);
	var d = instance_create_layer(focus_player.x, focus_player.y - 37, "Actors", objDice);
	d.focus_player = focus_player;
	d.network_id = player_id;
	focus_player.can_jump = true;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowDice);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_u64, random_get_seed());
		network_send_tcp_packet();
	}
}

function hide_dice() {
	var focus_player = focused_player();
	
	with (objDice) {
		focus_player.can_jump = false;
		layer_sequence_headpos(sequence, layer_sequence_get_length(sequence));
		layer_sequence_headdir(sequence, seqdir_left);
		layer_sequence_play(sequence);
	
		if (is_local_turn()) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.HideDice);
			network_send_tcp_packet();
		}
	}
}

function roll_dice() {
	//This code gets executes as if you were inside the dice you hit
	instance_destroy(objTurnChoices);
	var r = instance_create_layer(x, y - 16, "Actors", objDiceRoll);
	r.network_id = network_id;
	
	if (!global.board_started && roll <= 10) {
		roll = global.initial_rolls[network_id - 1];
	}
	
	if (roll > 10) {
		roll -= 10;
	}
	
	r.roll = roll;
	instance_destroy();
	audio_play_sound(sndDiceHit, 0, false);
	
	if (global.board_started) {
		var player_info = player_info_by_turn();
		bonus_shine_by_id(BonusShines.MostRoll).increase_score(global.player_turn, roll);
	} else {
		var player_info = {item_effect: -1};
	}
	
	var rolled_all_die = false;
	
	switch (player_info.item_effect) {
		case ItemType.DoubleDice:
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
			
		case ItemType.TripleDice:
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
	
	
	if (global.board_started && rolled_all_die) {
		objDiceRoll.target_x = focused_player().x;
	}
	
	if (is_local_turn() || !global.board_started) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.RollDice);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u8, r.roll);
		network_send_tcp_packet();
	}
}

function show_chest() {
	var focus_player = focused_player();
	instance_create_layer(focus_player.x, focus_player.y - 37, "Actors", objHiddenChest);
	audio_play_sound(sndHiddenChestSpawn, 0, false);
	
	if (focus_player.network_id == global.player_id) {
		achieve_trophy(3);
	}
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowChest);
		network_send_tcp_packet();
	}
}

function open_chest() {
	objHiddenChest.image_speed = 1;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.OpenChest);
		network_send_tcp_packet();
	}
}
#endregion

#region Stat Management
function change_shines(amount, type, player_turn = global.player_turn) {
	var s = instance_create_layer(0, 0, "Managers", objShineChange);
	s.player_info = player_info_by_turn(player_turn);
	s.focus_player = focus_player_by_turn(player_turn);
	s.network_id = s.focus_player.network_id;
	s.amount = amount;
	s.animation_type = type;
	
	if (sign(amount) == 1) {
		if (s.network_id == global.player_id) {
			global.collected_shines += amount;
			
			if (global.collected_shines >= 10) {
				achieve_trophy(0);
			}
			
			if (global.collected_shines >= 50) {
				achieve_trophy(1);
			}
			
			if (global.collected_shines >= 100) {
				achieve_trophy(2);
			}
		}
	}

	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeShines);
		buffer_write_data(buffer_s16, amount);
		buffer_write_data(buffer_u8, type);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
	
	return s;
}

function change_coins(amount, type, player_turn = global.player_turn) {
	var player_info = player_info_by_turn(player_turn);
	
	if (amount < 0) {
		amount = clamp(amount, -player_info.coins, 0);
	}
	
	var c = instance_create_layer(0, 0, "Managers", objCoinChange);
	c.player_info = player_info;
	c.focus_player = focus_player_by_turn(player_turn);
	c.network_id = c.focus_player.network_id;
	c.amount = amount;
	c.animation_type = type;
	
	if (sign(amount) == 1) {
		if (c.network_id == global.player_id) {
			global.collected_coins += amount;
		}
		
		bonus_shine_by_id(BonusShines.MostCoins).increase_score(player_turn, amount);
	}
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeCoins);
		buffer_write_data(buffer_s16, amount);
		buffer_write_data(buffer_u8, type);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
	
	return c;
}

function change_items(item, type, player_turn = global.player_turn) {
	var i = instance_create_layer(0, 0, "Managers", objItemChange);
	i.player_info = player_info_by_turn(player_turn);
	i.focus_player = focus_player_by_turn(player_turn);
	i.network_id = i.focus_player.network_id;
	i.animation_type = type;
	i.amount = (type == ItemChangeType.Gain) ? 1 : -1;
	i.item = item;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeItems);
		buffer_write_data(buffer_u8, item.id);
		buffer_write_data(buffer_u8, type);
		buffer_write_data(buffer_u8, player_turn);
		network_send_tcp_packet();
	}
	
	return i;
}

function calculate_player_place() {
	var scores = array_create(4, 0);
	
	for (var i = 1; i <= global.player_max; i++) {
		var player_info = player_info_by_id(i);
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
		for (var j = 1; j <= global.player_max; j++) {
			var player_info = player_info_by_id(j);
			
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
		case SpaceType.Green: case SpaceType.Item: color = c_green; break;
		case SpaceType.Warp: color = c_purple; break;
		case SpaceType.ChanceTime: color = c_yellow; break;
		case SpaceType.TheGuy: color = c_dkgray; break;
		default: color = c_gray; break;
	}
	
	player_info_by_turn().space = color;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeSpace);
		buffer_write_data(buffer_u8, space);
		network_send_tcp_packet();
	}
}

function item_applied(item) {
	var player_info = player_info_by_turn();
	
	switch (item.id) {
		case ItemType.DoubleDice:
		case ItemType.TripleDice:
		case ItemType.Clock:
			player_info.item_effect = item.id;
			break;
	}
	
	if (is_local_turn()) {
		switch (item.id) {
			case ItemType.Poison:
				show_multiple_player_choices(function(i) {
					return (player_info_by_turn(i).item_effect == null);
				}, false).final_action = function() {
					item_animation(ItemType.Poison);
				}
				break;
				
			case ItemType.Reverse:
				show_multiple_player_choices(function(i) {
					return (player_info_by_turn(i).item_effect == null);
				}, false).final_action = function() {
					item_animation(ItemType.Reverse);
				}
				break;
			
			case ItemType.Ice:
				show_multiple_player_choices(function(i) {
					return (player_info_by_turn(i).item_effect == null);
				}, true).final_action = function() {
					item_animation(ItemType.Ice);
				}
				break;
			
			case ItemType.Warp:
				item_animation(ItemType.Warp);
				break;
			
			case ItemType.SuperWarp:
				show_multiple_player_choices(function(_) { return true; }, true).final_action = function() {
					item_animation(ItemType.SuperWarp);
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
	i.type = item_id;
	i.sprite = item.sprite;
	i.additional = additional;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemAnimation);
		buffer_write_data(buffer_u8, item_id);
		buffer_write_data(buffer_s8, additional);
		network_send_tcp_packet();
	}
	
	return i;
}
#endregion

#region Interface Management
function show_popup(text, x = display_get_gui_width() / 2, y = display_get_gui_height() / 2, color = c_orange, snd = null, shrink = true, time = 1.2) {
	var p = instance_create_layer(x, y, "Managers", objPopup);
	p.text = text;
	p.color = color;
	p.snd = snd;
	p.shrink = shrink;
	p.time = time;
	return p;
}

function show_map() {
	instance_create_layer(0, 0, "Managers", objMapLook);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ShowMap);
		network_send_tcp_packet();
	}
}

function end_map() {
	instance_destroy(objMapLook);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndMap);
		network_send_tcp_packet();
	}
}

function call_shop() {
	player_info = player_info_by_turn();
	
	if (!global.board_day) {
		start_dialogue([
			new Message("Sorry but the shop is closed during the night, visit us at any time during the day. Thanks!",, board_advance)
		]);
		
		if (player_info.network_id == global.player_id && player_info.item_used == ItemType.Cellphone) {
			achieve_trophy(42);
		}
		
		exit;
	}
	
	if (global.board_turn == global.max_board_turns) {
		start_dialogue([
			new Message("We're currently closed!\nSorry for the inconvenience!",, board_advance)
		]);
		
		exit;
	}
	
	if (player_info.coins >= global.min_shop_coins) {
		start_dialogue([
			new Message("Do you wanna enter the shop?", [
				["Yes", [
					new Message("",, function() {
						instance_create_layer(0, 0, "Managers", objShop);
						objDialogue.endable = false;
					})
				]],
						
				["No", [
					new Message("",, function() {
						board_advance();
						
						if (player_info.network_id == global.player_id && player_info.item_used == ItemType.Cellphone) {
							achieve_trophy(45);
						}
					})
				]]
			])
		]);
	} else {
		start_dialogue([
			new Message("You don't have enough money to enter the shop!",, board_advance)
		]);
	}
}

function call_blackhole() {
	player_info = player_info_by_turn();
	
	if (room == rBoardIsland && global.board_day) {
		start_dialogue([
			new Message("I hate the day... please come back when it's nighttime.",, board_advance)
		]);
		
		exit;
	}
	
	if (player_info.coins >= global.min_blackhole_coins) {
		start_dialogue([
			new Message("Do you wanna use the blackhole?", [
				["Yes", [
					new Message("",, function() {
						instance_create_layer(0, 0, "Managers", objBlackhole);
						objDialogue.endable = false;
					})
				]],
						
				["No", [
					new Message("",, function() {
						board_advance();
						
						if (player_info.network_id == global.player_id && player_info.item_used == ItemType.Blackhole) {
							achieve_trophy(46);
						}
					})
				]]
			])
		]);
	} else {
		start_dialogue([
			new Message("You don't have enough money!",, board_advance)
		]);
	}
}

function show_multiple_choices(titles, choices, descriptions, availables) {
	global.choice_selected = -1;
	var m = instance_create_layer(0, 0, "Managers", objMultipleChoices);
	m.titles = titles;
	m.choices = choices;
	m.descriptions = descriptions;
	m.availables = availables;
	
	if (is_local_turn()) {
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

function show_multiple_player_choices(available_func, not_me = false) {
	return show_multiple_choices(all_player_names(not_me), all_player_choices(not_me), [], all_player_availables(available_func, not_me));
}

function all_player_names(not_me = false) {
	var player_info = player_info_by_turn();
	var names = [];
			
	for (var i = 1; i <= global.player_max; i++) {
		var player = player_info_by_turn(i);
		
		if (i == player_info.turn && not_me) {
			player = null;
		}
				
		if (player != null) {
			array_push(names, player.name);
		} else {
			array_push(names, "");
		}
	}
		
	return names;
}

function all_player_sprites(not_me = false) {
	var player_info = player_info_by_turn();
	var choices = [];
			
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		
		if (i == player_info.turn && not_me) {
			player = null;
		}
				
		if (player != null) {
			array_push(choices, get_skin_pose_object(player, "Idle"));
		} else {
			array_push(choices, "");
		}
	}
		
	return choices;
}

function all_player_choices(not_me = false) {
	var choices = all_player_sprites(not_me);
			
	for (var i = 0; i < array_length(choices); i++) {
		if (choices[i] != "") {
			choices[i] = "{SPRITE," + sprite_get_name(choices[i]) + ",0,-48,-64,3,3}";
		}
	}
		
	return choices;
}

function all_player_availables(func, not_me = false) {
	var player_info = player_info_by_turn();
	var availables = [];
			
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		
		if (i == player_info.turn && not_me) {
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

function all_item_stats(player_info) {
	var item_names = [];
	var item_sprites = [];
	var item_descs = [];
	var item_availables = [];
				
	for (var i = 0; i < array_length(player_info.items); i++) {
		var item = player_info.items[i];
					
		if (item == null) {
			array_push(item_names, "");
			array_push(item_sprites, "");
			array_push(item_descs, "");
			array_push(item_availables, false);
		} else {
			array_push(item_names, item.name);
			array_push(item_sprites, "{SPRITE," + sprite_get_name(item.sprite) + ",0,-32,-32,1,1}");
			array_push(item_descs, item.desc);
			array_push(item_availables, (array_length(player_info.items) <= 3) ? item.use_criteria() : true);
		}
	}
	
	return {
		names: item_names,
		sprites: item_sprites,
		descs: item_descs,
		availables: item_availables
	};
}
#endregion

#region Event Management
function choose_shine() {
	var choices = [];
	
	if (room != rBoardPallet) {
		with (objSpaces) {
			if (space_shine && image_index != SpaceType.Shine) {
				array_push(choices, id);
			}
		}
	} else {
		with (objBoardPalletPokemon) {
			if (!has_shine()) {
				array_push(choices, id);
			}
		}
	}
	
	array_shuffle(choices);
	var space = array_pop(choices);
	
	if (room != rBoardPallet) {
		space.image_index = SpaceType.Shine;
	} else {
		space = {x: space.x + 32, y: space.y + 32};
	}
	
	place_shine(space.x, space.y);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ChooseShine);
	buffer_write_data(buffer_s16, space.x);
	buffer_write_data(buffer_s16, space.y);
	network_send_tcp_packet();
}

function place_shine(space_x, space_y) {
	with (focused_player()) {
		if (room != rBoardPallet) {
			if (!instance_exists(objShine)) {
				with (objSpaces) {
					if (space_shine) {
						image_index = SpaceType.Blue;
					}
				}
			} else {
				with (instance_place(x, y, objSpaces)) {
					if (space_shine) {
						image_index = SpaceType.Blue;
					}
				}
			}
		}
	}
	
	if (room != rBoardPallet) {
		with (objSpaces) {
			if (x == space_x && y == space_y) {
				image_index = SpaceType.Shine;
				break;
			}
		}
	}
	
	var c = instance_create_layer(0, 0, "Managers", objChooseShine);
	c.space_x = space_x;
	c.space_y = space_y;
}

function start_chance_time() {
	instance_create_layer(0, 0, "Managers", objChanceTime);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartChanceTime);
		network_send_tcp_packet();
	}
}

function start_the_guy() {
	instance_create_layer(0, 0, "Managers", objTheGuy);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartTheGuy);
		network_send_tcp_packet();
	}
}

function board_hotland_annoying_dog() {
	instance_create_layer(0, 0, "Managers", objBoardHotlandAnnoyingDog);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardHotlandAnnoyingDog);
		network_send_tcp_packet();
	}
}

global.board_lock_event = false;

function board_pallet_pokemons() {
	pokemon = collision_circle(x + 16, y + 16, 64, objBoardPalletPokemon, false, true);
	var player_info = player_info_by_turn();

	if (player_info.coins >= global.pokemon_price) {
		bring_dialogues = [
			new Message("The Pokemon looks happy!",, function() {
				change_coins(-global.pokemon_price, CoinChangeType.Spend).final_action = function() {
					board_pallet_obtain(pokemon.sprite_index);
				}
			})
		];
	} else {
		bring_dialogues = [
			new Message("But you don't have " + draw_coins_price(global.pokemon_price) + "!",, board_advance)
		];
	}
	
	if (player_info.pokemon != -1) {
		battle_dialogues = [
			new Message("Give it your best shot!",, function() {
				board_pallet_battle(pokemon.sprite_index);
			})
		]
	} else {
		battle_dialogues = [
			new Message("You can't battle without a Pokemon!",, board_advance)
		];
	}

	start_dialogue([
		"Hey, there's a Pokemon here with the " + pokemon.power_type + " power.",
		new Message("What would you like to do with it?", [
			["Bring " + draw_coins_price(global.pokemon_price), bring_dialogues],
			["Battle", battle_dialogues],
			
			["Pass", [
				new Message("See you around!",, board_advance)
			]]
		])
	]);
}

function board_pallet_obtain(pokemon) {
	instance_create_layer(0, 0, "Managers", objBoardPalletObtain, {
		sprite: pokemon
	});
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardPalletObtain);
		buffer_write_data(buffer_u16, pokemon);
		network_send_tcp_packet();
	}
}

function board_pallet_battle(pokemon) {
	instance_create_layer(0, 0, "Managers", objBoardPalletBattle, {
		sprite: pokemon
	});
	
	//if (is_local_turn()) {
	//	buffer_seek_begin();
	//	buffer_write_action(ClientTCP.BoardPalletBattle);
	//	buffer_write_data(buffer_u16, pokemon);
	//	network_send_tcp_packet();
	//}
}

function board_dreams_teleports(reference) {
	var player = focused_player();
	
	with (objPlayerReference) {
		if (self.reference == reference) {
			if (global.board_lock_event) {
				return id;
			}
			
			player.x = x + 16;
			player.y = y + 16;
			
			break;
		}
	}
	
	switch_camera_target(player.x, player.y).final_action = board_advance;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.BoardDreamsTeleports);
		buffer_write_data(buffer_u8, reference);
		network_send_tcp_packet();
	}
}
#endregion

function disable_board() {
	instance_destroy(objPlayerInfo);
	instance_destroy(objBoard);
}