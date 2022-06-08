fade_start = -1;
fade_alpha = 0;

surf = noone;
surf2 = noone;

view_visible[6] = true;
view_wport[6] = 416;
view_hport[6] = 320;
var camera = view_camera[6];
camera_set_view_size(camera, 416, 320);
camera_set_view_pos(camera, 1600 + 192, 128);

view_visible[7] = true;
view_wport[7] = 800;
view_hport[7] = 608;
var camera = view_camera[7];
camera_set_view_size(camera, 800, 608);
camera_set_view_pos(camera, 800, 0);
