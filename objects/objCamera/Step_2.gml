if (target_follow != null) {
	target_x = target_follow.x;
	target_y = target_follow.y;
	var view_spd = (!global.choosing_shine) ? 0.2 : 0.05;
	view_x = lerp(view_x, target_x, view_spd);
	view_y = lerp(view_y, target_y, view_spd);
	
	if (global.choosing_shine && point_distance(view_x, view_y, target_x, target_y) < 50) {
		objChooseShine.alarm[1] = 1;
	}
	
	var width = camera_get_view_width(view_camera[0]);
	var height = camera_get_view_height(view_camera[0]);
	//view_x = clamp(view_x - width / 2, 0, room_width - width);
	//view_y = clamp(view_y - height / 2, 0, room_height - height);
	camera_set_view_pos(view_camera[0], view_x - width / 2, view_y - height / 2);
}