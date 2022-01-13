if (state == 0) {
	scale += 0.08;
	
	if (scale >= 1) {
		scale = 1;
		state = -1;
		
		if (!stealed) {
			alarm[1] = 1;
		
			if (is_player_turn()) {
				alarm[2] = get_frames((additional == 0) ? 5 : 0.5);
			}
		} else {
			if (is_player_turn()) {
				steal_count *= -1;
				alarm[2] = 1;
			}
		}
	}
} else if (state == 1) {
	scale -= 0.05;
	
	if (scale <= 0) {
		scale = 0;
		state = -1;
		
		if (!stealed) {
			alarm[3] = 1;
			stealed = true;
		} else {
			instance_destroy();
		}
	}
}

if (state == -1 && is_player_turn() && global.actions.jump.pressed()) {
	steal_count -= 0.1;
}