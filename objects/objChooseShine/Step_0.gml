if (fade_state == 1) {
	image_alpha += 0.04;
	
	if (image_alpha >= 1.2) {
		global.choosing_shine = false;
		
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