camera = 0;
target_follow = null;
view_spd = 0.2;
boundaries = false;

function init_view() {
	view_x = target_follow.x;
	view_y = target_follow.y;
	target_x = view_x;
	target_y = view_y;
}