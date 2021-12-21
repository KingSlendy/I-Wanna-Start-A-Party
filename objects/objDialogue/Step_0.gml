if (curve_perform) {
	curve_value = animcurve_channel_evaluate(curve_channel, curve_pos);
	curve_pos += curve_spd * ((curve_target == 1) ? 1 : -1);
	curve_offset = curve_value * height;
	
	if (abs(curve_target - curve_pos) <= 0) {
		curve_pos = curve_target;
		curve_value = animcurve_channel_evaluate(curve_channel, curve_pos);
		curve_offset = curve_value * height;
		curve_perform = false;
		
		if (curve_target == 0) {
			instance_destroy();
			exit;
		}
	}
}

if (active) {
	var answers = array_length(answer_displays);
	
	if (answers == 0) {
		repeat (array_length(text_display.branches)) {
			array_push(answer_displays, new Text(fntDialogue));
		}
	} else {
		var prev_answer = answer_index;
		var move = (global.down_action.pressed() - global.up_action.pressed());
		answer_index = (answer_index + move + answers) % answers;
		
		if (prev_answer != answer_index) {
			buffer_seek_begin();
			buffer_write_from_host(false);
			buffer_write_action(Client_TCP.ChangeDialogueAnswer);
			buffer_write_data(buffer_u8, answer_index);
			network_send_tcp_packet();
		}
	}
	
	if (answers > 0 && --text_delay > 0) {
		exit;
	}
	
	if (global.jump_action.pressed()) {
		text_advance();
	}
}