if (lost) {
	exit;
}

if (other.network_id != network_id) {
	instance_destroy(other);
}

if (image_alpha < 1 || !is_player_local(other.network_id) || other.network_id == network_id) {
	exit;
}

if (--hp <= 0) {
	player_kill();
	exit;
}

image_alpha = 0.5;
alarm[0] = get_frames(2);
audio_play_sound(sndHit, 0, false);