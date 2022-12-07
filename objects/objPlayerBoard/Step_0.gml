if ((is_local_turn() || !global.board_started) && can_jump && global.actions.jump.pressed(network_id)) {
	vspeed = -6;
	gravity = 0.4;
	dice_hit_y = y;
	can_jump = false;
	has_hit = true;
	audio_play_sound(sndJump, 0, false);
}