event_inherited();
player1 = focus_player_turn();
player2 = focus_player_turn(global.choice_selected + 1);
current_player = player2;

state = -1;
scale = 0;
angle = 0;

alarm[0] = 1;

function start_blackhole_steal() {
	alarm[1] = 1;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		buffer_write_action(Client_TCP.StartBlackholeSteal);
		network_send_tcp_packet();
	}
}