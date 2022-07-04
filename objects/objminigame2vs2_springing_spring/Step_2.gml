if (x < 400) {
	with (objPlayerBase) {
		if (player_info_by_id(network_id).turn == 2) {
			other.x = x - 16;
		}
	}
} else {
	with (objPlayerBase) {
		if (player_info_by_id(network_id).turn == 4) {
			other.x = x - 16;
		}
	}
}