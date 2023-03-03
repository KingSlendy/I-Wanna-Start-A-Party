var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
draw_set_alpha(image_alpha);
draw_set_color(c_white);
draw_rectangle(cam_x, cam_y, cam_x + 800, cam_y + 608, false);
draw_set_alpha(1);