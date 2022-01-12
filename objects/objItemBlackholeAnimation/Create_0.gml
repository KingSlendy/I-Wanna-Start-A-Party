event_inherited();
player1 = focus_player_turn();
player2 = focus_player_turn(global.choice_selected + 1);
current_player = player2;
global.shine_spawn_spot = {x: player1.x, y: player1.y};

state = -2;
scale = 0;
angle = 0;
steal_count = 20;
stealed = false;

alarm[0] = 1;

function start_blackhole_steal() {
	state = 0;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.StartBlackholeSteal);
		network_send_tcp_packet();
	}
}

function end_blackhole_steal() {
	state = 1;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndBlackholeSteal);
		buffer_write_data(buffer_u8, steal_count);
		network_send_tcp_packet();
	}
}