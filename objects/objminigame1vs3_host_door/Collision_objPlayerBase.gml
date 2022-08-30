var network_id = other.network_id;

if (image_index == 1 || !is_player_local(network_id)) {
	exit;
}

if (global.actions.up.pressed(network_id)) {
	with (objMinigameController) {
		set_pick_door(focus_player_by_id(network_id), other.id);
	}
}