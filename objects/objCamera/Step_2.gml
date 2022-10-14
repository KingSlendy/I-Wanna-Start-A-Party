if (target_follow == null) {
	exit;
}

try {
	//Position the view to the target coordinates
	target_x = target_follow.x;
	target_y = target_follow.y;
} catch (_) {}

view_w = camera_get_view_width(view_camera[camera]);
view_h = camera_get_view_height(view_camera[camera]);
var view_w_half = floor(view_w / 2);
var view_h_half = floor(view_h / 2);
view_x = lerp(view_x, target_x, view_spd);
view_y = lerp(view_y, target_y, view_spd);
	
//Clamp the view to the room boundaries if the variable is set to true
if (boundaries) {
	view_x = clamp(view_x, view_w_half, room_width - view_w_half);
	view_y = clamp(view_y, view_h_half, room_height - view_h_half);
}
	
camera_set_view_pos(view_camera[camera], view_x - view_w_half, view_y - view_h_half);