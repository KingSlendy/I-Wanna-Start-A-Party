/// @desc
var black_borders_thickness = 2;
// Background bar
draw_sprite_ext(pixel_sprite, 0, bar_x, bar_y, bar_width, bar_height, 0, c_black, 0.9);

// Progress bar
draw_sprite_ext(pixel_sprite, 0, bar_x, bar_y + black_borders_thickness, bar_width * bar_timeleft, bar_height - black_borders_thickness*2, 0, c_aqua, 1);

// Outline bar
draw_sprite_stretched_ext(outline_sprite, 0, bar_x, bar_y, bar_width, bar_height, c_white, 1);