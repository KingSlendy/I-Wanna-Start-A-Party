if (player_info_by_id(other.network_id).turn != objMinigameController.player_turn) {
	exit;
}

with (objMinigameController) {
	unfreeze_player();
}

instance_destroy();