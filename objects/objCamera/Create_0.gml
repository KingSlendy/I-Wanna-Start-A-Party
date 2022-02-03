target_follow = null;
view_spd = 0.2;
boundaries = false;

function init_view() {
	var width = camera_get_view_width(view_camera[0]);
	var height = camera_get_view_height(view_camera[0]);
	view_x = target_follow.x;
	view_y = target_follow.y;
	target_x = view_x;
	target_y = view_y;
}