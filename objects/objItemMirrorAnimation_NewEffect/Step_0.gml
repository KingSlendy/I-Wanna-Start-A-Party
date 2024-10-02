scale_factor = lerp(0, 8, time / duration);

pt1_scaleX = 1.3 * scale_factor;
pt1_scaleY = 1.1 * scale_factor;

pt2_scale = 1.0 * scale_factor;

part_type_scale(pt1, pt1_scaleX, pt1_scaleY);
part_type_scale(pt2, pt2_scale, pt2_scale);

time = min(time + 1, duration);

var cam_center_x = camera_get_view_x(view_camera[0]) + 400;
var cam_center_y = camera_get_view_y(view_camera[0]) + 304;

part_system_position(ps, cam_center_x, cam_center_y);