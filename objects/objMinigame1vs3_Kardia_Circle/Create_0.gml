cherry_amount = 32;
cherry_x = 400;
cherry_y = 304;
explosion_cooldown = get_frames(0.5);

function circle_move(move_angle, network = true) {
	with (objMinigame1vs3_Kardia_Cherry) {
		if (circle_reference == other.reference) {
			circle_angle -= move_angle * 2;
		}
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Kardia_CircleMove);
		buffer_write_data(buffer_u8, reference);
		buffer_write_data(buffer_s8, move_angle);
		network_send_tcp_packet();
	}
}

function circle_shoot(network = true) {
	var temp_cherry_x = cherry_x;
	var temp_cherry_y = cherry_y;
	
	with (objMinigame1vs3_Kardia_Cherry) {
		if (circle_reference == other.reference && image_index != 0) {
			var explosion_amount = 4 + circle_reference;
			var angle = point_direction(x, y, temp_cherry_x, temp_cherry_y);
			
			for (var i = 0; i < 360; i += 360 / explosion_amount) {
				with (instance_create_layer(x, y, "Actors", objMinigame1vs3_Kardia_Cherry)) {
					explosion_angle = (i + angle + 360) % 360;
					explosion_distance = point_distance(x, y, temp_cherry_x, temp_cherry_y);
					image_index = other.image_index;
					speed = 6 + other.circle_reference;
					direction = explosion_angle;
				}
			}
			
			image_blend = c_gray;
		}
	}
	
	explosion_cooldown = get_frames(1.5);
	audio_play_sound(sndShoot, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame1vs3_Kardia_CircleShoot);
		buffer_write_data(buffer_u8, reference);
		network_send_tcp_packet();
	}
}