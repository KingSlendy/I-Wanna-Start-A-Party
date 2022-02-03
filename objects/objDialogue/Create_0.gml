event_inherited();
depth = -10009;
image_alpha = 0;

width = 0;
height = 0;
border_width = 10;

active = true;
endable = true;
texts = [];
text_branch = null;
text_index = 0;
text_display = null;
text_delay = 0;
answer_index = 0;
answer_displays = [];

dialogue_sprite = noone;
text_surf = noone;

alpha_target = 1;

function text_advance() {
	if (array_length(text_branch) == 0) {
		text_display = new Message(new Text(fntDialogue,, 1));
		return;
	}
	
	if (text_display != null && text_display.text.tw_active) {
		text_display.text.skip();
		//audio_play_sound(global.sound_cursor_mini_select, 0, false);
		
		if (is_local_turn()) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.SkipDialogueText);
			network_send_tcp_packet();
		}
		
		return;
	}
	
	if (text_index > 0) {
		var event = text_branch[text_index - 1].event;
		
		if (event != null) {
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
		if (set_text.event != null) {
			set_text.event();
		}
		
		text_end();
		return;
	}
	
	text_display = set_text;
	text_display.text.tw_active = true;
	text_index++;
	text_delay = 20;
	answer_index = 0;
	answer_displays = [];
	
	//audio_play_sound(global.sound_cursor_mini_select, 0, false);
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.ChangeDialogueText);
		buffer_write_data(buffer_string, text_display.text.original_text);
		
		for (var i = 0; i < array_length(text_display.branches); i++) {
			buffer_write_data(buffer_string, text_display.branches[i][0]);
		}
		
		buffer_write_data(buffer_string, "EOA");
		buffer_write_data(buffer_u8, text_display.text.tw_spd);
		network_send_tcp_packet();
	}
}

function text_start() {
	text_branch = texts;
	text_advance();
}

function text_end() {
	active = false;
	
	if (endable) {
		alpha_target = 0;
		
		if (is_local_turn()) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.EndDialogue);
			network_send_tcp_packet();
		}
	}
}

function text_change(text, tw_spd = 1) {
	text_display.text.set(text);
	text_display.text.tw_reset();
	text_display.text.tw_spd = tw_spd;
	answer_index = 0;
	answer_displays = [];
}