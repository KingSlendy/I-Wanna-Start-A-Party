camera = 0;
target_follow = null;
view_spd = 0.2;
boundaries = false;

function init_view() {
	view_w = camera_get_view_width(view_camera[camera]);
	view_h = camera_get_view_height(view_camera[camera]);
	target_w = view_w;
	target_h = view_h;
	
	if (object_index == objCamera) {
		view_x = target_follow.x;
		view_y = target_follow.y;
	} else {
		view_x = target_follow.x - floor(view_w / 2);
		view_y = target_follow.y - floor(view_h / 2);
	}
	
	target_x = view_x;
	target_y = view_y;
}