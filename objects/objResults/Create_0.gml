fade_start = true;
fade_alpha = 1;

with (objPlayerBase) {
	change_to_object(objPlayerParty);
}

with (objPlayerBase) {
	image_xscale = 2;
	image_yscale = 2;
	x = 230 + 110 * (player_info_by_id(network_id).turn - 1);
	y = 500;
	lost = false;
}

lights_moving = false;
lights_spd = [];

for (var i = 0; i < global.player_max; i++) {
	array_push(lights_spd, random_range(3, 5));
}

lights_angle = array_create(global.player_max, 0);
revealed = false;

global.board_started = false;
info = global.minigame_info;

function results_coins() {
	for (var i = 0; i < array_length(info.players_won); i++) {
		change_coins(10, CoinChangeType.Gain, player_info_by_id(info.players_won[i]).turn);
	}
	
	alarm[0] = get_frames(3.3);
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsCoins);
		network_send_tcp_packet();
	}
}

function results_won() {
	alarm[1] = get_frames(3);
	lights_moving = true;
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsWon);
		network_send_tcp_packet();
	}
}

function results_end() {
	fade_start = true;
	
	if (global.player_id == 1) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ResultsEnd);
		network_send_tcp_packet();
	}
}
