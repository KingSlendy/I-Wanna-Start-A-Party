draw_set_alpha(alpha);
draw_set_color((next_turn == -1 && !info.is_finished) ? c_white : c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);