if (!is_player_local(other.network_id) || image_alpha < 1) {
	exit;
}

with (other) {
	player_kill();
}