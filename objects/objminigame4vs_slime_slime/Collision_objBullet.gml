instance_destroy(other.object_index);

if (!is_player_local(other.network_id)) {
	exit;
}

slime_shot();