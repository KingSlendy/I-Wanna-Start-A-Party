global.choice_selected = (global.choice_selected + 1 + minigame_total) % minigame_total;
audio_play_sound(sndCursorSelect, 0, false);

if (is_local_turn()) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ChangeMultipleChoiceSelected);
	buffer_write_data(buffer_u8, global.choice_selected);
	network_send_tcp_packet();
}

minigames_timer += 0.10;

if (minigames_timer > 6 && irandom(1) == 0 && global.choice_selected == minigames_chosen) {
	info.reference = minigame_list[global.choice_selected];
	send_to_minigame();
	exit;
}

alarm[2] = minigames_timer;