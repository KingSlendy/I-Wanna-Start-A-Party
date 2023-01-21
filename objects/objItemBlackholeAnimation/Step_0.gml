event_inherited();

if (state == 0) {
	scale += 0.08;
	
	if (scale >= 1) {
		scale = 1;
		state = -1;
		
		if (!stealed) {
			image_speed = 1;
			image_index = 0;
			alarm_frames(1, 1);
		
			if (is_local_turn()) {
				alarm_call(2, (additional == 0) ? 5 : 0.5);
			}
		} else {
			if (is_local_turn()) {
				steal_count *= -1;
				alarm_frames(2, 1);
			}
		}
	}
} else if (state == 1) {
	scale -= 0.05;
	image_speed = 0;
	image_index = 0;
	alarm_stop(1);
	
	if (scale <= 0) {
		scale = 0;
		state = -2;
		
		if (!stealed) {
			alarm_frames(3, 1);
			stealed = true;
		} else {
			instance_destroy();
		}
	}
}

if (is_local_turn() && state == -1 && player_info_by_turn().item_effect != ItemType.Ice && global.actions.jump.pressed(player2.network_id)) {
	steal_count -= 0.2;
	steal_count = max(steal_count, steal_min);
}