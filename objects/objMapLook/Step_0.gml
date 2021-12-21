if (global.shoot_action.pressed()) {
	instance_destroy();
	exit;
}

var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);
var scroll_h = (global.right_action.held() - global.left_action.held());
var scroll_v = (global.down_action.held() - global.up_action.held());
look_x += scroll_h * 8;
look_y += scroll_v * 8;
look_x = clamp(look_x, 0, room_width - cam_w * 0.25);
look_y = clamp(look_y, 0, room_height - cam_h * 0.25);
objCamera.target_follow = {x: look_x, y: look_y};