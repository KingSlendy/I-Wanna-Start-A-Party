if (target_follow != null) {
	//Position the view to the target coordinates
	target_x = target_follow.x;
	target_y = target_follow.y;
	view_x = lerp(view_x, target_x, view_spd);
	view_y = lerp(view_y, target_y, view_spd);
	
	//Clamp the view to the room boundaries if the variable is set to true
	var width = camera_get_view_width(view_camera[camera]);
	var height = camera_get_view_height(view_camera[camera]);
	
	if (boundaries) {
		view_x = clamp(view_x, width / 2, room_width - width / 2);
		view_y = clamp(view_y, height / 2, room_height - height / 2);
	}
	
	camera_set_view_pos(view_camera[camera], view_x - width / 2, view_y - height / 2);
}