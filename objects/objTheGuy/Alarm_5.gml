if (alarm[8] != -1) {
	exit;
}

if (instance_exists(objStatChange)) {
	alarm[5] = 1;
	exit;
}

objTheGuyHead.snd = audio_play_sound(sndTheGuyCrushBones, 0, false);

if (is_local_turn()) {
	start_dialogue([
		new Message("Hope you think twice before landing on my space again.",, end_the_guy)
	]);
	
	buffer_seek_begin();
	buffer_write_action(ClientTCP.CrushTheGuy);
	network_send_tcp_packet();
}
