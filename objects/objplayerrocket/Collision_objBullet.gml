if (lost) {
	exit;
}

if (image_alpha < 1 || other.network_id == network_id) {
	exit;
}

if (--hp <= 0) {
	player_kill();
	audio_stop_sound(audio_idle_looping);
	exit;
}

image_alpha = 0.5;
alarm_call(0, 2);
audio_play_sound(sndHit, 0, false);