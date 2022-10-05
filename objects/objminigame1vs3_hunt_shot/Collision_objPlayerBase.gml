if (!is_player_local(other.network_id) || image_xscale < 0.85) {
	exit;
}

with (other) {
	player_kill();
}