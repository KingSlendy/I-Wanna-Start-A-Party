if (get_player_count(objPlayerParty) < global.player_max || menu_page != 0 || prev_skin_player == skin_player || focus_player_by_id(prev_skin_player + 1).sprite_index == sprPlayerBlank) {
	exit;
}

with (focus_player_by_id(prev_skin_player + 1)) {
	other.skin_selected[network_id - 1] = get_skin_index_by_sprite(sprite_index);
}

prev_skin_player = skin_player;