if (!is_player_local(other.network_id)) {
	exit;
}

if (global.actions.jump.pressed(other.network_id)) {
	platform_paint(other.network_id);
}