if (!is_player_local(other.network_id)) {
	exit;
}

if (trg >= 8 && other.vspd > 0 && image_index == 0) {
	press_button();
}