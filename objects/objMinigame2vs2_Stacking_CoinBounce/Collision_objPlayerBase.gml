if (objMinigameController.info.is_finished || other.coin_can_toss) {
	exit;
}

if (is_player_local(other.network_id)) {
	other.coin_can_toss = true;
}

instance_destroy();