numbers = [];
number_digits = 4;
number_sections = 7;

for (var i = 0; i < number_digits; i++) {
	array_push(numbers, []);
	
	for (var j = 0; j < number_sections; j++) {
		array_push(numbers[i], false);
	}
}

border_length = 9;
number_length = sprite_get_width(sprMinigame4vs_Clockwork_DigitalBack);
dots_length = sprite_get_width(sprMinigame4vs_Clockwork_DigitalDots);
player = null;

function clock_digital_digits_draw(number_x, number_y, number_index, draw) {
	for (var i = 0; i < number_sections; i++) {
		var is_colliding = false;
		
		if (is_player_local(player.network_id)) {
			var temp_sprite_index = sprite_index;
			var temp_x = x;
			var temp_y = y;

			sprite_index = sprMinigame4vs_Clockwork_DigitalNumber;
			image_index = i;
			x = number_x;
			y = number_y;
			
			with (player) {
				is_colliding = (collision_circle(x, y, 3, other, true, true) != noone);
			}
			
			sprite_index = temp_sprite_index;
			image_index = 0;
			x = temp_x;
			y = temp_y;
			
			if (is_colliding && global.actions.jump.pressed(player.network_id)) {
				clock_digital_section_toggle(number_index, i);
			}
		}

		if (!numbers[number_index][i] && !is_colliding) {
			continue;
		}
	
		draw_sprite(sprMinigame4vs_Clockwork_DigitalNumber, i + ((!is_colliding) ? 0 : number_sections), number_x, number_y);
	}
}

function clock_digital_section_toggle(digit, section, network = true) {
	numbers[digit][section] ^= true;
	audio_play_sound(sndMinigame4vs_Clockwork_DigitalSwap, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Clockwork_ClockDigitalSectionToggle);
		buffer_write_data(buffer_u8, network_id);
		buffer_write_data(buffer_u8, digit);
		buffer_write_data(buffer_u8, section);
		network_send_tcp_packet();
	}
}

function clock_digital_correct_time(network = true) {
	with (objMinigameController) {
		alarm_stop(10);
	}
	
	minigame4vs_points(network_id, 1);
	objMinigame4vs_Clockwork_ClockAnalog.check_target_time = false;
	objPlayerBase.frozen = true;
	audio_play_sound(sndMinigame4vs_Clockwork_DigitalDing, 0, false);
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Clockwork_ClockDigitalCorrectTime);
		buffer_write_data(buffer_u8, network_id);
		network_send_tcp_packet();
	}
	
	if (minigame4vs_get_points(network_id) >= 3) {
		minigame_finish();
		exit;
	}
	
	with (objMinigame4vs_Clockwork_ClockAnalog) {
		alarm_call(1, 1);
	}
}