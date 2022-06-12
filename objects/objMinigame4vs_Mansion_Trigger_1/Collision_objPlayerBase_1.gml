var network_id = other.network_id;

with (objMinigameController) {
	minigame4vs_points(info, network_id);
	minigame_finish();
}

instance_destroy();
