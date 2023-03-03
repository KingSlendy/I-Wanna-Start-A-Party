if (!is_player_local(other.network_id) || other.index != 1 || portion != height) {
	exit;
}

whac_idol(other.network_id);