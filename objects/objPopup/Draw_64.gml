draw_set_font(fntPopup);
draw_set_color(color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_outline(x, y, text, scale, scale, 0, c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);