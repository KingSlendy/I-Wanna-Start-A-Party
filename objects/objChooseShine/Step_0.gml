with (objCamera) {
	if (other.fade_state != 2) {
		target_follow = {x: other.space_x + 16, y: other.space_y + 16};
	}
	
	target_x = target_follow.x;
	target_y = target_follow.y;
	
	if (point_distance(view_x, view_y, target_x, target_y) < 50) {
		with (other) {
			spawn_shine();
		}
	}
}

if (fade_state == 1) {
	image_alpha += 0.04;
	
	if (image_alpha >= 1.2) {
		global.board_started = true;
		
		with (objCamera) {
			event_perform(ev_step, ev_step_begin);
			view_x = target_follow.x;
			view_y = target_follow.y;
		}
		
		fade_state = 2;
	}
} else if (fade_state == 2) {
	image_alpha -= 0.05;
	
	if (image_alpha <= 0) {
		instance_destroy();
	}
}