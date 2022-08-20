draw_sprite_ext(sprite_index, image_index, x, y, scale, 1, 0, c_white, 1);
draw_sprite_ext(sprite_index, image_index + 1, x + sprite_width * scale, y, 1 - scale, 1, 0, c_white, 1);
//draw_set_color(c_black);
//draw_rectangle(x, y, x + (sprite_width - 1), y + (sprite_height - 1), true);