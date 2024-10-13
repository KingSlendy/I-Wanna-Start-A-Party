event_inherited();

if (target_follow != null) {
	with (objCamera) {
		target_follow = other.target_follow;
		
		target_x = target_follow.x;
		target_y = target_follow.y;
		view_x = target_x;
		view_y = target_y;
	}
}

cloud_x = lerp(cloud_x, cloud_target_x, 0.2);

if (cloud_mode == 1) {
	cloud_alpha += 0.04;
	
	if (cloud_alpha >= 1) {
		cloud_alpha = 1;
		cloud_mode = 0;
		alarm_call(2, 1);
	}
} else if (cloud_mode == -1) {
	cloud_alpha -= 0.04;
	
	if (cloud_alpha <= 0) {
		cloud_alpha = 0;
		cloud_mode = 0;
		
		if (is_local_turn()) {
			choose_shine();
		}
		
		instance_destroy();
	}
}