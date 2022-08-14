if (objMinigameController.info.is_finished) {
	exit;
}

if (x < 192) {
	with (objMinigame1vs3_Coins_Spike) {
		if (follow != null) {
			exit;
		}
	}
	
	if (!threw && follow == null && global.actions.shoot.pressed(other.network_id)) {
		follow = other;
		with (objMinigameController) {
			alarm_call(5, 0.25);
		}

		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Coins_HoldSpike);
		buffer_write_data(buffer_u32, count);
		network_send_tcp_packet();
	}
} else {
	with (other) {
		if (hittable && image_alpha == 1) {
			with (objPlayerBase) {
				if (x < 192) {
					minigame4vs_points(network_id, 1);
					break;
				}
			}
			
			if (is_player_local(network_id)) {
				image_alpha = 0.5;
				alarm_call(0, 1);
			}
			
			audio_play_sound(sndDeath, 0, false);
		}
		
		hittable = false;
		
		if (network_id == global.player_id) {
			objMinigameController.trophy_hit = false;
		}
	}
}
