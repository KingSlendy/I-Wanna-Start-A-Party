/// @desc Draw BG

// Get camera current position
var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

var xx = remap(camX, -400, room_width - 400, 0, bg_width);
var yy = remap(camY, -304, room_height - 304, 0, bg_height);
draw_sprite_ext(space_sprite, 0, -xx, -yy, 1, 1, 0, image_blend, 1);