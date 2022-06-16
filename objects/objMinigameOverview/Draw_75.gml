draw_set_alpha(alpha);
draw_set_color((state == 0) ? c_black : c_white);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);
