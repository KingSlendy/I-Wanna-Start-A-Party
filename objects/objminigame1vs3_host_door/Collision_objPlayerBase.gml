if (!is_player_local(other.network_id)) {
	exit;
}

if (global.actions.up.pressed(other.network_id)) {
	pick_door(other.network_id);
}