with (objPlayerBase) {
	if (!is_player_local(network_id)) {
		continue;
	}
	
	enable_shoot = false;
}

if (objMinigameController.player_turn != 0) {
	with (focus_player_by_turn(objMinigameController.player_turn)) {
		if (!is_player_local(network_id) || lost) {
			break;
		}
	
		enable_shoot = place_meeting(x, y, other);
	}
}