if (objMinigameController.info.is_finished || !is_player_local(other.network_id)) {
	exit;
}

treasure_obtained(other.network_id);