with (objPlayerBase) {
	if (object_index != objNetworkPlayer && !frozen) {
		other.info.player_scores[network_id - 1].timer++;
	}
}
