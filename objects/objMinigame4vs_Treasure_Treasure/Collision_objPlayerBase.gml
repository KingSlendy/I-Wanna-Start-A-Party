if (objMinigameController.info.is_finished || !is_player_local(other.network_id)) {
	exit;
}

if (other.network_id == global.player_id && objMinigameController.trophy_obtain) {
	achieve_trophy(81);
}

treasure_obtained(other.network_id);