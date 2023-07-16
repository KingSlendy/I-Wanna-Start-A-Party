if ((global.board_started || network_id == global.player_id) && is_player_turn()) {
	controls_text.set(draw_action_small(global.actions.jump) + " " + language_get_text("WORD_GENERIC_JUMP") + "\n\n" + ((global.board_started && !instance_exists(objDiceRoll)) ? draw_action_small(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_CANCEL") : ""));
	controls_text.draw(360, 320 + ((!global.board_started) ? 20 : 0));
}