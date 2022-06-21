if (objMinigameController.info.is_finished) {
	exit;
}

if (x < 400) {
	with (objMinigame1vs3_Coins_Spike) {
		if (follow != null) {
			exit;
		}
	}
	
	if (!threw && follow == null && global.actions.shoot.pressed(other.network_id)) {
		follow = other;
		objMinigameController.alarm[5] = get_frames(0.25);
		
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Coins_HoldSpike);
		buffer_write_data(buffer_u32, count);
		network_send_tcp_packet();
	}
} else {
	with (other) {
		if (image_alpha == 1) {
			with (objPlayerBase) {
				if (x < 400) {
					minigame4vs_points(objMinigameController.info, network_id, 1);
					break;
				}
			}
			
			audio_play_sound(sndDeath, 0, false);
		}
		
		if (is_player_local(network_id)) {
			image_alpha = 0.5;
			alarm[0] = get_frames(1);
		}
	}
}
