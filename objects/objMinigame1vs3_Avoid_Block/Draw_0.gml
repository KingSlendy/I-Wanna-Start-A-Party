draw_set_color(c_black);
draw_rectangle(x, y, x + 31, y + 31, false);

draw_set_color(merge_color(image_blend, c_gray, (image_index == attack) ? 0 : 0.5));
draw_rectangle(x, y + (alarm_remain(10) / get_frames(2.4)) * 31, x + 31, y + 31, false);

draw_set_color(c_black);
draw_rectangle(x, y, x + 31, y + 31, true);