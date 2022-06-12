if (global.board_started || network_id == global.player_id) {
	var text = new Text(fntControls);
	text.set(draw_action_small(global.actions.jump) + " Jump\n\n" + ((global.board_started) ? draw_action_small(global.actions.shoot) + " Cancel" : ""));
	text.draw(360, 320 + ((!global.board_started) ? 20 : 0));
}
