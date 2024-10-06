instance_destroy(other);

if (!is_player_local(other.network_id)) {
	exit;
}

spike_shoot(other.network_id);