if (is_player_turn()) {
	focus_player = focused_player();
} else {
	focus_player = focus_player_by_id(1);
}

network_id = focus_player.network_id;