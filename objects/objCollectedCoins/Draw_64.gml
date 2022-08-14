draw_sprite_ext(sprCoin, 0, 20, y, image_xscale, image_xscale, 0, c_white, 1);
draw_set_font(fntPlayerInfo);
draw_set_color(c_white);
draw_set_valign(fa_middle);
draw_text_outline(40, y, string(coins), c_black);
draw_set_valign(fa_top);