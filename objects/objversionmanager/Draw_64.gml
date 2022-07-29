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
	draw_set_font(fntFilesData);
	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);
	var sent_mb = string_format(sent / 1000000, 2, 3);
	draw_text(200, 200 - 8, sent_mb);
	draw_text(200, 200 - 8 - string_height(sent_mb) - 2, "MB");
	draw_set_halign(fa_center);
	draw_text(400, 200 - 8, "/");
	draw_set_halign(fa_right);
	var size_mb = string_format(size / 1000000, 2, 3);
	draw_text(600, 200 - 8, size_mb);
	draw_text(600, 200 - 8 - string_height(size_mb) - 2, "MB");
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(400, 300 + 8, VERSION + " -> " + version);
	draw_set_halign(fa_left);
}