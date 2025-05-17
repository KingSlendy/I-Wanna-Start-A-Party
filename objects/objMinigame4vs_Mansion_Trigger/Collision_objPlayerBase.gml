if (!objMinigameController.announcer_started) {
	return;
}

var network_id = other.network_id;

with (objMinigameController) {
	if (network_id == global.player_id && trophy_doors) {
		achieve_trophy(14);
	}
	
	minigame4vs_points(network_id);
	minigame_finish();
}

instance_destroy();