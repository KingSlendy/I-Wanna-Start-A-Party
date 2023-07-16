if (state != -1) {
	language_set_font(global.fntDialogue);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_outline(x, y - 16, counter, c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}