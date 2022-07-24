draw_set_font(fntTitle);
draw_set_color(c_white);
draw_text_outline(0, 540, text, c_black);

if (downloading) {
	draw_set_color(c_white);
	draw_rectangle(200, 200, 600, 300, false);
	draw_set_color(c_black);
	draw_rectangle(210, 210, 590, 290, false);
	draw_set_color(c_white);
	draw_rectangle(220, 220, 220 + (580 - 220) * (sent / size), 280, false);
	draw_set_font(fntTitleStart);
	draw_text(0, 0, string_format(sent / 1000000, 2, 3) + "MB/" + string_format(size / 1000000, 2, 3) + "MB");
}