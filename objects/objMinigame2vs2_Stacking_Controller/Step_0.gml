timer++;

if (info.is_finished) {
	exit;
}

with (objPlayerBase) {
	if (y < 304) {
		if (is_player_local(network_id) && coin_can_toss && global.actions.shoot.pressed(network_id)) {
			with (other) {
				coin_toss(other.network_id);
			}
		}
	} else {
		if (is_player_local(network_id) && array_length(coin_line_stack) > 2) {
			if (hspd != 0) {
				do {
					coin_line_stack_velocity += sign(hspd) * -(0.04 + (array_length(coin_line_stack) * 0.002));
				} until (coin_line_stack_velocity != 0);
			}
		
			coin_line_stack_angle = (coin_line_stack_angle + coin_line_stack_velocity + 360) % 360;
			coin_line_stack_separation = array_length(coin_line_stack) * 0.3;
			var coin_coords1 = other.coin_calculate_coords(x, y, 0, coin_line_stack_angle, coin_line_stack_separation);
			var coin_coords2 = other.coin_calculate_coords(x, y, 1, coin_line_stack_angle, coin_line_stack_separation);
	
			if ((array_length(coin_line_stack) <= 4 && point_distance(coin_line_stack_angle, 0, 90, 0) >= 90) || point_distance(coin_coords1.coord_x, 0, coin_coords2.coord_x, 0) > max(sprite_get_width(sprMinigame2vs2_Stacking_CoinStack) / 2 - coin_line_stack_separation, 4)) {
				with (other) {
					coin_line_stack_fall(other.network_id);
				}
			}
			
			buffer_seek_begin();
			buffer_write_action(ClientUDP.Minigame2vs2_Stacking_CoinLineStack);
			buffer_write_data(buffer_u8, network_id);
			buffer_write_data(buffer_f16, coin_line_stack_angle);
			buffer_write_data(buffer_f16, coin_line_stack_velocity);
			buffer_write_data(buffer_f16, coin_line_stack_separation);
			network_send_udp_packet();
		}
	
		for (var i = 0; i < array_length(coin_line_stack); i++) {
			var coin = coin_line_stack[i];
			var coin_coords = other.coin_calculate_coords(x, y, i, coin_line_stack_angle, coin_line_stack_separation);
			coin.x = coin_coords.coord_x;
			coin.y = coin_coords.coord_y;
		}
	}
}