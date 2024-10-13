if (!is_player_local(other.network_id)) {
	exit;
}

if (first && other.network_id == global.player_id) {
	achieve_trophy(85);
}

with (other) {
	player_kill();
}