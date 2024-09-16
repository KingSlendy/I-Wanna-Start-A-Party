hspd = 0;
vspd = 0;
grav = 0;
grav_amount = 0.2;
coin_id = floor(x) + floor(y);
following_id = null;

function coin_follow(network_id, network = true) {
	sprite_index = sprMinigame2vs2_Stacking_CoinFollow;
	following_id = network_id;
	vspd = 0;
	grav = 0;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Stacking_CoinFollow);
		buffer_write_data(buffer_u16, coin_id);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}

function coin_unfollow(network = true) {
	sprite_index = sprMinigame2vs2_Stacking_Coin;

	if (network) {
		var player = focus_player_by_id(following_id);
		hspd = player.hspd;
	
		if (player.vspd <= 0) {
			vspd = player.vspd * 5;
			vspd = max(vspd, -8);
		}
		
		while (collision_line(bbox_left - 1, y, bbox_left - 1, y + (sprite_height - 1), objBlock, false, true)) {
			x++;
		}
	
		while (collision_line(bbox_right + 1, y, bbox_right + 1, y + (sprite_height - 1), objBlock, false, true)) {
			x--;
		}
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Stacking_CoinUnfollow);
		buffer_write_data(buffer_u16, coin_id);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		buffer_write_data(buffer_s8, hspd);
		buffer_write_data(buffer_s8, vspd);
		network_send_tcp_packet();
	}
	
	following_id = null;
}

function coin_depth_first_search() {
	
}