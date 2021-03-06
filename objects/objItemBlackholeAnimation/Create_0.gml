event_inherited();
player1 = focus_player_by_turn();
player2 = focus_player_by_turn(global.choice_selected + 1);
current_player = player2;

state = -2;
scale = 0;
angle = 0;
stealed = false;

steal_min = min(irandom_range(7, 11), player_info_by_id(player2.network_id).coins);

alarm[0] = 1;

function start_blackhole_steal() {
	state = 0;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartBlackholeSteal);
		network_send_tcp_packet();
	}
}

function end_blackhole_steal() {
	state = 1;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndBlackholeSteal);
		buffer_write_data(buffer_u8, steal_count);
		network_send_tcp_packet();
	}
}