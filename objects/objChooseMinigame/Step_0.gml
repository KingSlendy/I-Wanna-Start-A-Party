if (state == 0) {
	alpha += 0.03;
	
	if (alpha >= 1) {
		zoom = true;
		
		//Camera points to the middle of the room
		event_perform(ev_step, ev_step_begin);
		
		with (objCamera) {
			view_x = target_follow.x;
			view_y = target_follow.y;
			target_x = view_x;
			target_y = view_y;
		}
		
		//Doubles the view size
		camera_set_view_size(view_camera[0], 800 * 2.5, 608 * 2.5);
		alpha = 1;
		state = 1;
	}
} else if (state == 1) {
	alpha -= 0.05;
	
	if (alpha <= 0) {
		with (objPlayerInfo) {
			
		}
		
		alpha = 0;
		state = -1;
	}
}