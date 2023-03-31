draw_self();

switch (image_index) {
	case 0: var points = 1; break;
	case 1: var points = 2; break;
	case 2: var points = -1; break;
	case 3: var points = -2; break;
}

draw_set_font(fntControls);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_outline(x, y, string(points), c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);