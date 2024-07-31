/// @desc Draw BG

// Get camera current position
var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_y(view_camera[0]);

var xx = remap(camX, -400, room_width - 400, 0, bg_width - 800);
var yy = remap(camY, -304, room_height - 304, 0, bg_height - 608);

var drawX = camX - xx;
var drawY = camY - yy;
draw_sprite_ext(space_sprite, 0, drawX, drawY, 1, 1, 0, image_blend, 1);

