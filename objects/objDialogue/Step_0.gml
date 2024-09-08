image_alpha = lerp(image_alpha, alpha_target, 0.3);

if (alpha_target == 0 && point_distance(image_alpha, 0, alpha_target, 0) < 0.01) {
	instance_destroy();
	exit;
}

if (active && text_display != null) {
	var answers = array_length(answer_displays);
	
	if (answers == 0) {
		repeat (array_length(text_display.branches)) {
			array_push(answer_displays, new Text(global.fntDialogue));
		}
	} else if (!text_display.text.tw_active) {
		var prev_answer = answer_index;
		var move = (global.actions.down.pressed(network_id) - global.actions.up.pressed(network_id));
		answer_index = (answer_index + move + answers) % answers;
		
		if (prev_answer != answer_index) {
			audio_play_sound(global.sound_cursor_move, 0, false);
			
			buffer_seek_begin();
			buffer_write_action(ClientUDP.ChangeDialogueAnswer);
			buffer_write_data(buffer_u8, answer_index);
			network_send_udp_packet();
		}
	}
	
	if (answers > 0 && --text_delay > 0) {
		exit;
	}
	
	if (global.actions.jump.pressed(network_id)) {
		text_advance();
		global.actions.jump.consume();
	}
}