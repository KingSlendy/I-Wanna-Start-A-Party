draw_self();

if (layer_sequence_is_finished(sequence) && layer_sequence_get_headdir(sequence) == 1) {
	language_set_font(global.fntDice);
	draw_set_alpha(1);
	draw_set_color(make_color_rgb(244, 233, 0));
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(x, y - 16, string(roll), c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}