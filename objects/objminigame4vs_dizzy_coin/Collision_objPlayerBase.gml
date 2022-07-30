if (!is_player_local(other.network_id)) {
	exit;
}

if (player_color_by_turn(player_info_by_id(other.network_id).turn) == image_blend) {
	grab_coin(other.network_id);
}