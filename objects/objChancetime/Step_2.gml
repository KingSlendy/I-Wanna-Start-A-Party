for (var i = 1; i <= global.player_max; i++) {
	with (focus_player_by_turn(i)) {
		if (id != other.current_player && !array_contains(other.player_ids, network_id)) {
			visible = false;
		}
	}
}