draw_self();

if (state != -1) {
	draw_set_font(fntDialogue);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_outline(x, y - 16, counter, c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}