if (!is_player_local(other.network_id) || other.network_id != minigame1vs3_solo().network_id || image_alpha < 1) {
	exit;
}

with (other) {
	player_kill();
}