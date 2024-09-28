if (!is_player_local(other.network_id) || player_info_by_id(other.network_id).turn != objMinigameController.player_turn || other.lost) {
	exit;
}

slime_blocking();