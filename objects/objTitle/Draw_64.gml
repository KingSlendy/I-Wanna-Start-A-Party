draw_set_font(fntTitle);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 1; i <= 4; i++) {
	draw_text_transformed_color_outline(title_x, title_y + i, title_text, title_scale, title_scale, 0, title_alpha, c_purple);
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_sprite_ext(title_sprite, 0, title_x, title_y, title_scale, title_scale, 0, c_white, title_alpha);
