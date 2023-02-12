if (player_info_by_id(other.network_id).turn != objMinigameController.player_turn || other.lost) {
	exit;
}

with (objMinigameController) {
	unfreeze_player();
}

instance_destroy();