event_inherited();

points_draw = true;
player_type = objPlayerGolf;

player_turn = 1;
next_turn = -1;

trophy_main = true;

function unfreeze_player() {
	var player = focus_player_by_turn(player_turn);
	player.frozen = false;
}

function give_points(player_id, points, network = true) {
	minigame4vs_points(player_id, points);
	
	if (focus_player_by_turn(player_turn).network_id == global.player_id && points == 99) {
		achieve_trophy(62);
	}
	
	if (player_turn == global.player_max) {
		minigame_finish();
	} else {
		next_turn = 0;
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Golf_GivePoints);
		buffer_write_data(buffer_u8, player_id);
		buffer_write_data(buffer_u16, points);
		network_send_tcp_packet();
	}
}

alarm_override(1, function() {
	unfreeze_player();
});

alarm_override(2, function() {
	alarm_inherited(2);
	
	if (array_contains(info.players_won, global.player_id)) {
		if (trophy_main) {
			achieve_trophy(66);
		}
	}
});