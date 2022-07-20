if (!is_player_local(other.network_id) || other.image_xscale <= 1) {
	exit;
}

finish_race(true);