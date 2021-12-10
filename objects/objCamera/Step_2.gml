if (target_follow != null) {
	target_x = target_follow.x;
	target_y = target_follow.y;
}

view_x = lerp(view_x, target_x, 0.2);
view_y = lerp(view_y, target_y, 0.2);
var width = camera_get_view_width(view_camera[0]);
var height = camera_get_view_height(view_camera[0]);
//view_x = clamp(view_x - width / 2, 0, room_width - width);
//view_y = clamp(view_y - height / 2, 0, room_height - height);
camera_set_view_pos(view_camera[0], view_x - width / 2, view_y - height / 2);