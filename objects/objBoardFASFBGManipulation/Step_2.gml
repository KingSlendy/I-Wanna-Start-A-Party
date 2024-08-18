/// @desc
/*
// Get camera current position
var camX = camera_get_view_x(view_camera[0]);
var camY = camera_get_view_x(view_camera[0]);

// Move background layer
layer_x(layer_space,  remap(camX, -400, room_width - 800, 0, bg_width));
layer_y(layer_space,  remap(camY, -304, room_height - 608, 0, bg_height));