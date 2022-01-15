if (is_local_turn() && !focus_player.ai && focus_player.can_jump && global.actions.shoot.pressed(network_id)) {
	hide_dice();
}