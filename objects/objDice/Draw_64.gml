if (global.board_started || network_id == global.player_id) {
	controls_text.set(draw_action_small(global.actions.jump) + " Jump\n\n" + ((global.board_started && !instance_exists(objDiceRoll)) ? draw_action_small(global.actions.shoot) + " Cancel" : ""));
	controls_text.draw(360, 320 + ((!global.board_started) ? 20 : 0));
}