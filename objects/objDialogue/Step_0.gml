if (curve_perform) {
	curve_value = animcurve_channel_evaluate(curve_channel, curve_pos);
	curve_pos += curve_spd * ((curve_target == 1) ? 1 : -1);
	curve_y = curve_value * height;
	
	if (abs(curve_target - curve_pos) < curve_spd) {
		curve_pos = curve_target;
		curve_y = curve_target;
		curve_perform = false;
		
		if (curve_target == 0) {
			instance_destroy();
		}
	}
}

if (active) {
	var answers = array_length(answer_displays);
	
	if (answers == 0) {
		if (!text_display.text.tw_active) {
			repeat (array_length(text_display.branches)) {
				array_push(answer_displays, new Text(fntDialogue));
			}
		}
	} else {
		var move = (global.down_action.pressed() - global.up_action.pressed());
		answer_index = (answer_index + move + answers) % answers;
	}
	
	if (answers > 0 && --text_delay > 0) {
		exit;
	}
	
	if (global.jump_action.pressed()) {
		text_advance();
	}
}