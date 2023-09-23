if (!is_player_local(other.network_id) || other.frozen) {
	exit;
}

if (global.actions.up.pressed(other.network_id)) {
	open_door();
	
	with (focus_player_by_id(other.network_id)) {
		door = other.id;
		frozen = true;
		alarm_call(0, 2);
	}
}