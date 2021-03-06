draw_set_font(fntTitle);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 1; i <= 6; i++) {
	draw_text_transformed_color_outline(title_x, title_y + i, title_text, title_scale, title_scale, 0, c_black, c_black, c_black, c_black, title_alpha, c_ltgray);
}

draw_sprite_ext(title_sprite, 0, title_x, title_y, title_scale, title_scale, 0, c_white, title_alpha);

if (start_visible) {
	draw_set_font(fntTitleStart);
	draw_text_color_outline(400, 520, "PRESS START", c_lime, c_lime, c_fuchsia, c_fuchsia, 1, c_black);
}

draw_set_font(fntTitleCreator);
draw_set_color(c_white);
draw_text_outline(400, 590, "MADE BY KINGSLENDY", c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
