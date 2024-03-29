if (!shoot_start || info.is_finished) {
	exit;
}

if (minigame1vs3_solo().lost) {
	minigame_time_end();
	exit;
}

if (minigame1vs3_solo().network_id == global.player_id) {
	var all_blocks = true;
			
	with (objBlock) {
		if (image_xscale != 1 || image_yscale != 1 || !(x >= 0 && x <= 800 && y >= 0 && y <= 608)) {
			continue;
		}
				
		if (!touched) {
			all_blocks = false;
			break;
		}
	}
			
	if (all_blocks) {
		achieve_trophy(53);
	}
}

for (var i = 0; i < minigame1vs3_team_length(); i++) {
	var player = minigame1vs3_team(i);
	
	if (player.reticle == null) {
		with (objMinigame1vs3_Hunt_Reticle) {
			if (index == i) {
				player.reticle = id;
				break;
			}
		}
	}
	
	shoot_delay[i] = max(--shoot_delay[i], 0);
	
	if (shoot_delay[i] == 0 && global.actions.shoot.pressed(player.network_id)) {
		create_shoot(player.reticle.x, player.reticle.y);
		shoot_delay[i] = get_frames(0.9);
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Hunt_ReticleShoot);
		buffer_write_data(buffer_s32, player.reticle.x);
		buffer_write_data(buffer_s32, player.reticle.y);
		network_send_tcp_packet();
	}
	
	var move_h = (global.actions.right.held(player.network_id) - global.actions.left.held(player.network_id));
	var move_v = (global.actions.down.held(player.network_id) - global.actions.up.held(player.network_id));
	
	if (move_h == 0 && move_v == 0) {
		continue;
	}
	
	with (player.reticle) {
		x += move_h * player.max_hspd;
		y += move_v * player.max_hspd;
		x = clamp(x, 0, room_width);
		y = clamp(y, 0, room_height);
			
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Hunt_ReticleMove);
		buffer_write_data(buffer_u8, i);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}