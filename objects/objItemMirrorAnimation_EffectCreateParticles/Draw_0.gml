draw_set_alpha(image_alpha);
draw_set_color(c_black);
draw_rectangle(-400, -304, room_width + 400, room_height + 304, false);
draw_set_alpha(1);

// We didn't reset their color before
draw_set_color(c_white);