if (player_info_by_id(other.network_id).turn != objMinigameController.player_turn || other.lost) {
	exit;
}

with (objMinigameController) {
	block_entrance();
}

instance_destroy();