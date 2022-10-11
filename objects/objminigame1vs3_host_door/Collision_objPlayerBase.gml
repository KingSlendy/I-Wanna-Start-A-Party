var network_id = other.network_id;

if (other.frozen || image_index == 1) {
	exit;
}

if (minigame1vs3_is_solo(network_id) && !array_contains(other.touched_doors, id)) {
	array_push(other.touched_doors, id);
}

if (!is_player_local(network_id)) {
	exit;
}

if (global.actions.up.pressed(network_id)) {
	with (objMinigameController) {
		set_pick_door(focus_player_by_id(network_id), other.id);
	}
}