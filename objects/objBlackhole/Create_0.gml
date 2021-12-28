width = 400;
height = 150;
stock = [
	{text: "{SPRITE,sprCoin,0,0,2,0.6,0.6} ", name: "Coins", desc: "A", price: 5},
	{text: "{SPRITE,sprShine,0,-6,-5,0.5,0.5}", name: "Shine", desc: "B", price: 50}
];

option_selected = -1;
option_previous = 0;
item_selected = -1;
shopping = true;
player_turn_info = get_player_turn_info();
offset_target = 1;
offset_pos = 0;
offset_y = -454;

function blackhole_end() {
	offset_target = 0;
	
	if (is_player_turn()) {
		buffer_seek_begin();
		buffer_write_from_host(false);
		//buffer_write_action(Client_TCP.EndBlackhole);
		//network_send_tcp_packet();
	}
}

if (is_player_turn()) {
	buffer_seek_begin();
	buffer_write_from_host(false);
	//buffer_write_action(Client_TCP.ShowBlackhole);
	//network_send_tcp_packet();
}