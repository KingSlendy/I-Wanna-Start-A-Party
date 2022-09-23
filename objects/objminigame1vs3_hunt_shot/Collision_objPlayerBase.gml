if (!is_player_local(other.network_id) || image_xscale < 0.75) {
	exit;
}

with (other) {
	player_kill();
}