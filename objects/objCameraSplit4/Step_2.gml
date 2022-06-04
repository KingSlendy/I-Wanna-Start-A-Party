for (var i = 0; i < global.player_max; i++) {
	var follow = target_follow[i];
		
	//Position the view to the target coordinates
	if (!lock_x && !dead[i]) {
		target_x[i] = follow.x;
	}
	
	if (!lock_y && !dead[i]) {
		target_y[i] = follow.y;
	}
	
	view_x[i] = lerp(view_x[i], target_x[i], view_spd);
	view_y[i] = lerp(view_y[i], target_y[i], view_spd);
	
	//Clamp the view to the room boundaries if the variable is set to true
	var width = camera_get_view_width(view_camera[i]);
	var height = camera_get_view_height(view_camera[i]);
	
	if (boundaries) {
		view_x[i] = clamp(view_x[i], 0, room_width - width / 2);
		view_y[i] = clamp(view_y[i], 0, room_height - height / 2);
	}
	
	camera_set_view_pos(view_camera[i], view_x[i] - width / 2, view_y[i] - height / 2);
}