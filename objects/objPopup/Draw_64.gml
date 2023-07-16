if (room != rResults) {
	language_set_font(global.fntPopup);
	draw_set_color(color);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed_color_outline(x, y, text, scale, scale, 0, c_orange, c_orange, c_yellow, c_yellow, 1, c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
} else {
	draw_sprite_ext(sprResultsPartyStar, 0, 400, 200, scale, scale, 0, c_white, 1);
}