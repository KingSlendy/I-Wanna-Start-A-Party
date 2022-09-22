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
		
		var rnd = irandom(99);
		
		if (rnd <= 50 || array_count(player_info_by_turn().items, null) == 0) {
			change_coins(30, CoinChangeType.Gain).final_action = final_action;
		} else if (rnd >= 51 && rnd <= 98) {
			change_items(global.board_items[choose(ItemType.Blackhole, ItemType.Mirror)], ItemChangeType.Gain).final_action = final_action;
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
			case 0: text = "Oh no! The Guy spaces are gonna take over Red spaces!\nI hope he has mercy..."; break;
			case 1: text = "Red spaces are gonna be Chance Time spaces!?\nAnything could happen now!"; break;
			case 2: text = "Whoa! Red spaces are now Item spaces!\nTime to collect items everyone!"; break;
			case 3: text = "No more Blue spaces!?\nThat's gonna be rough on the wallet!"; break;
		}
		
		start_dialogue([
			text,
			"And also...\nRemember that Blue and Red spaces are double the amount of coins too!",
			new Message("I wish good luck to everyone and have a great party!",, end_last_turns)
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
	show_popup("LAST 5 TURNS");
	alarm_call(1, 2);
});

alarm_create(function() {
	if (is_local_turn()) {
		var texts = [
			"Good party everyone! It has been super fun so far, but we're nearing the end, only a couple turns left!",
			new Message("This is the perfect time to spice things up a little bit, but first let's see how everyone is doing so far...",, say_player_place)
		];
	
		for (var i = 1; i <= global.player_max; i++) {
			with (objPlayerInfo) {
				if (order == i) {
					var p_info = id;
					break;
				}
			}
		
			var text = "{COLOR,0000FF}" + p_info.player_info.name + "{COLOR,FFFFFF} is in {SPRITE,sprPlayerInfoPlaces," + string(p_info.player_info.place - 1) + ",0,0,0.6,0.6} place.";
			array_push(texts, (i < global.player_max) ? new Message(text,, say_player_place) : text);
		}
	
		array_push(texts, new Message("Looks like {COLOR,0000FF}" + p_info.player_info.name + "{COLOR,FFFFFF} is having some trouble... let's give them a little bit of help!",, help_last_place));
		start_dialogue(texts);
	}
});

alarm_create(function() {
	if (is_local_turn()) {
		start_dialogue([
			"Since you're already here, how about a little something extra?",
			new Message("Hit the block to reveal what exciting event is gonna be applied to the whole board!",, spawn_last_turns_box)
		]);
	}
});