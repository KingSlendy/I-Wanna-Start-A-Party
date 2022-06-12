if (global.board_started && is_local_turn() && focus_player.can_jump && global.actions.shoot.pressed(global.player_id)) {
	hide_dice();
}