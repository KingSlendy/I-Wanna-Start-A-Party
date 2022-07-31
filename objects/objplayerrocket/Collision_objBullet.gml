if (lost) {
	exit;
}

if (image_alpha < 1 || other.network_id == network_id) {
	exit;
}

if (--hp <= 0) {
	player_kill();
	exit;
}

image_alpha = 0.5;
alarm[0] = get_frames(2);
audio_play_sound(sndHit, 0, false);