width = 0;
height = 0;
border_width = 10;

active = true;
endable = true;
texts = [];
text_branch = undefined;
text_index = 0;
text_display = undefined;
text_delay = 0;
answer_index = 0;
answer_displays = [];

dialogue_sprite = noone;
text_surf = noone;

curve_perform = true;
curve_type = crvDialogue;
curve_channel = animcurve_get_channel(curve_type, "Pos");
curve_target = 1;
curve_pos = 0;
curve_spd = 0.05;
curve_value = 1;
curve_y = -1;

function text_advance() {
	if (text_display != undefined && text_display.text.tw_active) {
		text_display.text.skip();
		return;
	}
	
	if (text_index > 0) {
		var event = text_branch[text_index - 1].event;
		
		if (event != noone) {
			event();
		}
	}
	
	var set_text = text_branch[clamp(text_index, 0, array_length(text_branch) - 1)];
	
	if (text_index == array_length(text_branch)) {
		if (array_length(set_text.branches) == 0) {
			text_end();
			return;
		} else {
			text_index = 0;
			text_branch = set_text.branches[answer_index][1];
			set_text = text_branch[text_index];
		}
	}
	
	//The current text is empty so that means it's just an event
	if (set_text.text.text == "") {
		set_text.event();
		text_end();
		return;
	}
	
	text_display = set_text;
	text_display.text.tw_active = true;
	text_index++;
	text_delay = 20;
	answer_displays = [];
}

function text_start() {
	text_branch = texts;
	text_advance();
}

function text_end() {
	active = false;
	
	if (endable) {
		curve_target = 0;
		curve_perform = true;
	}
}

function text_change(text) {
	text_display.text.set(text);
	text_display.text.tw_reset();
	text_delay = 20;
	answer_displays = [];
}