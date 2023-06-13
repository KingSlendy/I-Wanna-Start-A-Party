with (objPlayerReference) {
	if (reference == 1) {
		other.focus_player = id;
		break;
	}
}

current_follow = {x: focus_player.x + 17, y: focus_player.y + 23};
prev_player_positions = store_player_positions();

function minigame_info_placement() {
	places_minigame_repeated = array_create(global.player_max, 0);
	places_minigame_info = [];
	places_minigame_order = [];
		
	for (var i = 1; i <= global.player_max; i++) {
		var info = focus_info_by_turn(i);
		var order = info.player_info.place + places_minigame_repeated[info.player_info.place - 1];
		places_minigame_repeated[info.player_info.place - 1]++;
		array_push(places_minigame_info, info);
		array_push(places_minigame_order, order);
	}
}

minigame_info_placement();

for (var i = 0; i < global.player_max; i++) {
	var p_info = places_minigame_info[i];
	var order = places_minigame_order[i];
	
	with (p_info) {
		target_draw_x = 800 + draw_w;
		target_draw_y = 32 + (draw_h + 8) * (order - 1);
		draw_x = target_draw_x;
		draw_y = target_draw_y;
		self.order = order;
	}
}

current_player = 1;
event = -1;
previous_turn = global.player_turn;
global.player_turn = player_info_by_id(1).turn;

function say_player_place() {
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.LastTurnsSayPlayerPlace);
		network_send_tcp_packet();	
	}
	
	with (objPlayerInfo) {
		if (order == other.current_player) {
			var p_info = id;
			break;
		}
	}
			
	with (p_info) {
		target_draw_x = 800 - draw_w;
		target_draw_y = 32 + (draw_h + 8) * (order - 1);
	}
	
	current_player++;
}

function help_last_place() {
	switch_camera_target(focus_player.x, focus_player.y).final_action = give_last_place;
	
	with (objPlayerInfo) {
		if (order == 4) {
			var player = focus_player_by_id(player_info.network_id);
			player.x = other.focus_player.x + 17;
			player.y = other.focus_player.y + 23;
			break;
		}
	}
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.LastTurnsHelpLastPlace);
		network_send_tcp_packet();
	}
}

function give_last_place() {
	with (objPlayerInfo) {
		if (order == 4) {
			global.player_turn = player_info.turn;
			break;
		}
	}
	
	if (is_local_turn()) {
		var final_action = function() {
			with (objLastTurns) {
				alarm_frames(2, 1);
			}
		}
		
		desync_seed_offline();
		var rnd = irandom(99);
		
		if (rnd <= 50 || array_count(player_info_by_turn().items, null) == 0) {
			change_coins(30, CoinChangeType.Gain).final_action = final_action;
		} else if (rnd >= 51 && rnd <= 98) {
			var item = choose(ItemType.Blackhole, ItemType.Mirror);
			change_items(global.board_items[item], ItemChangeType.Gain).final_action = final_action;
		} else {
			change_shines(1, ShineChangeType.Spawn).final_action = final_action;
			
			if (focused_player().network_id == global.player_id) {
				achieve_trophy(61);
			}
		}
	}
}

function spawn_last_turns_box() {
	instance_create_layer(focus_player.x + 17, focus_player.y + 23 - 37, "Actors", objLastTurnsBox);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.SpawnLastTurnsBox);
		network_send_tcp_packet();
	}
}

function event_decided() {
	if (is_local_turn()) {
		var text = "";
		
		switch (event) {
			case 0: text = language_get_text("PARTY_LAST_FIVE_SPACES_RED_GUY"); break;
			case 1: text = language_get_text("PARTY_LAST_FIVE_SPACES_RED_CHANCE"); break;
			case 2: text = language_get_text("PARTY_LAST_FIVE_SPACES_RED_ITEM"); break;
			case 3: text = language_get_text("PARTY_LAST_FIVE_SPACES_RED_BLUE"); break;
			case 4: text = language_get_text("PARTY_LAST_FIVE_SPACES_RED_SURPRISE"); break;
		}
		
		start_dialogue([
			text,
			language_get_text("PARTY_LAST_FIVE_REMEMBER_DOUBLE"),
			new Message(language_get_text("PARTY_LAST_FIVE_GOOD_LUCK"),, end_last_turns)
		]);
	}
}

function end_last_turns() {
	state = 0;
	music_fade();
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.LastTurnsEndLastTurns);
		network_send_tcp_packet();
	}
}

fade_alpha = 0;
state = -1;
music_fade();

alarms_init(3);

alarm_create(function() {
	music_pause();
	music_change(bgmLastTurns);
	show_popup(language_get_text("PARTY_LAST_FIVE_POPUP"));
	alarm_call(1, 2);
});

alarm_create(function() {
	if (is_local_turn()) {
		var texts = [
			language_get_text("PARTY_LAST_FIVE_GOOD_PARTY"),
			new Message(language_get_text("PARTY_LAST_FIVE_LETS_SEE"),, say_player_place)
		];
	
		for (var i = 1; i <= global.player_max; i++) {
			with (objPlayerInfo) {
				if (order == i) {
					var p_info = id;
					break;
				}
			}
		
			var text = language_get_text("PARTY_LAST_FIVE_PLACES", "{COLOR,0000FF}", p_info.player_info.name, "{COLOR,FFFFFF}", "{SPRITE,sprPlayerInfoPlaces," + string(p_info.player_info.place - 1) + ",0,0,0.6,0.6}")
			array_push(texts, (i < global.player_max) ? new Message(text,, say_player_place) : text);
		}
	
		array_push(texts, new Message(language_get_text("PARTY_LAST_FIVE_TROUBLE", "{COLOR,0000FF}", p_info.player_info.name, "{COLOR,FFFFFF}"),, help_last_place));
		start_dialogue(texts);
	}
});

alarm_create(function() {
	if (is_local_turn()) {
		start_dialogue([
			language_get_text("PARTY_LAST_FIVE_ALREADY_HERE"),
			new Message(language_get_text("PARTY_LAST_FIVE_HIT_BLOCK"),, spawn_last_turns_box)
		]);
	}
});