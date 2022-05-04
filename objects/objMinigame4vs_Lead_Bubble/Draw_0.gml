draw_self();

if (action_shown != -1) {
	draw_set_font(fntDialogue);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(x, y + sprite_height * 0.55, action_text[action_shown], c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}
