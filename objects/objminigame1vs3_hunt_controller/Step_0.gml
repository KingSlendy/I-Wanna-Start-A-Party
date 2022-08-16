if (!shoot_start || info.is_finished) {
	exit;
}

if (points_teams[1][0].lost) {
	minigame_time_end();
	exit;
}

for (var i = 0; i < array_length(points_teams[0]); i++) {
	var player = points_teams[0][i];
	var reticle;
	
	with (objMinigame1vs3_Hunt_Reticle) {
		if (index == i) {
			reticle = id;
			break;
		}
	}
	
	shoot_delay[i] = max(--shoot_delay[i], 0);
	
	if (shoot_delay[i] == 0 && global.actions.shoot.pressed(player.network_id)) {
		create_shoot(reticle.x, reticle.y);
		shoot_delay[i] = get_frames(0.75);
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Hunt_ReticleShoot);
		buffer_write_data(buffer_s32, reticle.x);
		buffer_write_data(buffer_s32, reticle.y);
		network_send_tcp_packet();
	}
	
	var move_h = (global.actions.right.held(player.network_id) - global.actions.left.held(player.network_id));
	var move_v = (global.actions.down.held(player.network_id) - global.actions.up.held(player.network_id));
	
	if (move_h == 0 && move_v == 0) {
		continue;
	}
	
	with (reticle) {
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