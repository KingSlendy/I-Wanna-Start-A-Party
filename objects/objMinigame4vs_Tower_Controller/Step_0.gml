//instance_deactivate_all(true);

//for (var i = 0; i < 4; i++) {
//	var cam = view_camera[i];
//	var cam_x = camera_get_view_x(cam);
//	var cam_y = camera_get_view_y(cam);
//	var cam_w = camera_get_view_width(cam);
//	var cam_h = camera_get_view_height(cam);
//	instance_activate_region(cam_x, cam_y, cam_w, cam_h, true);
//}

//instance_activate_important();
//instance_activate_object(objPlatform);

if (info.is_finished) {
	exit;
}

var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count >= global.player_max - 1) {
	minigame_time_end();
}
