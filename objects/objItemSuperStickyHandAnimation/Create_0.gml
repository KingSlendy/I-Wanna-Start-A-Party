event_inherited();
player_turn_selected = global.choice_selected + 1;
player1 = focus_player_by_turn();
player2 = focus_player_by_turn(player_turn_selected);
player_info = player_info_by_turn(player_turn_selected);
current_player = player2;

state = -1;
fade_alpha = 0;
ypos = 0;
scale = 1;

item_stole = null;

function start_hand() {
	if (is_player_local(player1.network_id)) {
		var items = all_item_stats(player_info, false);		
		show_multiple_choices(language_get_text("PARTY_ITEM_WHICH_ITEM_STEAL"), items.names, items.sprites, items.descs, items.availables).final_action = turn_hand;
	}
}

function turn_hand(network = true) {
	turn_previous = global.player_turn;
	global.player_turn = player_turn_selected;
	state = 0;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemSuperStickyHandAnimation_TurnHand);
		network_send_tcp_packet();
	}
}

function steal_hand(network = true) {
	alarm_instant(2);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemSuperStickyHandAnimation_StealHand);
		network_send_tcp_packet();
	}
}

function end_hand() {
	if (is_player_local(player1.network_id)) {
		change_items(item_stole, ItemChangeType.Gain).final_action = destroy_hand;
	}
}

function destroy_hand(network = true) {
	instance_destroy();
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ItemStickyHandAnimation_DestroyHand);
		network_send_tcp_packet();
	}
}

action = method(id, start_hand);

alarms_init(3);

alarm_create(function() {
	switch_camera_target(current_player.x, current_player.y).final_action = action;
});

alarm_create(function() {
	item_stole = player_info.items[global.choice_selected];
	
	if (is_player_local(player1.network_id)) {
		if (item_stole.id == ItemType.StickyHand) {
			achieve_trophy(83);
		}
	}
	
	if (is_player_local(player2.network_id)) {
		change_items(item_stole, ItemChangeType.Lose).final_action = steal_hand;
	}
});

alarm_create(function() {
	current_player = player1;
	global.player_turn = turn_previous;
	action = method(id, end_hand);
	alarm_frames(0, 1);
});

alarm_frames(0, 1);