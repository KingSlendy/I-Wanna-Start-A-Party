image_index = irandom(image_number - 1);
spike_id = (floor(y) div 32) * 25 + floor(x) div 32;

function spike_shoot(network_id, network = true) {
	var player_blue = objMinigameController.points_teams[0][0];
	var player_red = objMinigameController.points_teams[1][0];
	var player_self, player_other;

	if (image_blend == c_blue) {
		player_self = player_blue;
		player_other = player_red;
	} else if (image_blend == c_red) {
		player_self = player_red;
		player_other = player_blue;
	}

	minigame4vs_points(player_self.network_id, 1);
	var is_same_color = (player_info_by_id(network_id).space == image_blend);

	if (!is_same_color && minigame2vs2_get_points(player_other.network_id, player_other.teammate.network_id) > 0) {
		minigame4vs_points(player_other.network_id, -1);
	}

	var exists_same_color = false;

	with (object_index) {
		if (id != other.id && image_blend == other.image_blend) {
			exists_same_color = true;
			break;
		}
	}

	if (!exists_same_color) {
		minigame_finish();
	}
	
	audio_play_sound(sndMinigame2vs2_Castle_SpikeShoot, 0, false,,, irandom_range(1, 1.3));
	var s = instance_create_layer(x + 16, y + 16, layer, objMinigame2vs2_Castle_SpikeFade);
	s.image_index = image_index;
	s.image_blend = image_blend;
	instance_destroy();

	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame2vs2_Castle_SpikeShoot);
		buffer_write_data(buffer_u16, spike_id);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
}