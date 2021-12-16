if (is_player_turn() && can_jump && global.jump_action.pressed()) {
	vspeed = -6;
	gravity = 0.4;
	dice_hit_y = y;
	can_jump = false;
}