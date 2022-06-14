if (player == null || !is_player_local(player.network_id)) {
	exit;
}

if (held && !player.frozen && global.actions.jump.released(player.network_id)) {
	release_item();
}
