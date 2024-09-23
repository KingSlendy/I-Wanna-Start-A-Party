network_id = null;
coin_id = -1;
hspd = 0;
vspd = 0;
grav = 0.2;
stacked_id = null;
stacked_falling = false;
fall_spd = 0;
outside = false;

function coin_line_stack_add(network_id, network = true) {
	if (stacked_id != null) {
		return;
	}
	
	var player = focus_player_by_id(network_id);
	
	with (player) {
		array_push(coin_line_stack, other.id);
	}
	
	vspd = 0;
	grav = 0;
	
	stacked_id = player;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Stacking_CoinLineStackAdd);
		buffer_write_data(buffer_u8, self.network_id);
		buffer_write_data(buffer_u16, coin_id);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}