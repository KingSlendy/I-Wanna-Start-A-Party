if (player == null || !is_player_local(player.network_id) || other.frozen) {
	exit;
}

if (!held && grab && global.actions.jump.pressed(player.network_id)) {
	hold_item();
}
