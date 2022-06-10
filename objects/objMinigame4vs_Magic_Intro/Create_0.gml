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
show_view_x = 0;
show_view_y = 0;

view_visible[7] = true;
view_wport[7] = 800;
view_hport[7] = 608;
var camera = view_camera[7];
camera_set_view_size(camera, 800, 608);
camera_set_view_pos(camera, 800, 0);
draw_views = true;

time = 3;
quake = false;
fall_order = array_sequence(0, 10);
fall_current = 0;
array_shuffle(fall_order);
alarm[11] = get_frames(1);
alarm[0] = get_frames(5);
