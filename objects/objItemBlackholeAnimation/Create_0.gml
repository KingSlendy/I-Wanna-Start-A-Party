event_inherited();
player1 = focus_player_turn();
player2 = focus_player_turn(global.choice_selected + 1);
current_player = player2;

state = -1;
scale = 0;
angle = 0;
steal_count = 20;

alarm[0] = 1;

function start_blackhole_steal() {
	state = 0;
	buffer_seek_begin();
	buffer_write_action(Client_TCP.StartBlackholeSteal);
	network_send_tcp_packet();
}