if ((is_local_turn() || !global.board_started) && can_jump && global.actions.jump.pressed(network_id)) {
	board_jump();
	has_hit = true;
}