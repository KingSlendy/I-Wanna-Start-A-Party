if (!is_player_local(other.network_id) || !visible) {
	exit;
}

collect_key(other.network_id);