if (!is_player_local(other.network_id)) {
	exit;
}

with (other) {
	player_kill();
}