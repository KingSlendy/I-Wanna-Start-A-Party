info = global.minigame_info;
layer_background_index(layer_background_get_id("Background"), array_get_index(minigame_types(), info.type));

with (objPlayerBase) {
	change_to_object(objPlayerBase);
}

with (objPlayerBase) {
	draw = false;
	lost = false;
}

instructions = [];

for (var i = 0; i < array_length(info.reference.instructions); i++) {
	array_push(instructions, new Text(global.fntDialogue));
}

instructions_page = 0;
option_selected = -1;
choice_texts = [
	language_get_text("MINIGAMES_MODE_NORMAL"),
	language_get_text("MINIGAMES_MODE_PRACTICE")
];

state = 0;
fade_alpha = 1;

pages_text = new Text(global.fntControls);
controls_text = new Text(global.fntControls);

function start_minigame(set, network = true) {
	state = set;
	music_fade();
	
	if (state != 3) {
		audio_play_sound(sndMinigameOverviewPick, 0, false);
	} else {
		audio_play_sound(global.sound_cursor_back, 0, false);
	}
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.MinigameOverviewStart);
		buffer_write_data(buffer_u8, state);
		network_send_tcp_packet();
	}
}