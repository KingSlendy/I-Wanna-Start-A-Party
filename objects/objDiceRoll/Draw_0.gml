draw_set_font(fntDice);
draw_set_alpha(1);
draw_set_color(make_color_rgb(244, 233, 0));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_outline(objPlayerBoard.x, (follow_y) ? objPlayerBoard.y - 53 : y, string(global.dice_roll), c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);