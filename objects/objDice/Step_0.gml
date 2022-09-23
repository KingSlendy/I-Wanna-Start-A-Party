if (global.board_started && is_local_turn() && focus_player.can_jump && !instance_exists(objDiceRoll) && global.actions.shoot.pressed(network_id)) {
	hide_dice();
}