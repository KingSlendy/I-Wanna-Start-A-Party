exit;
language_set_font(global.fntTest);
draw_set_color(c_white);
draw_text(0, 0, "This is text with ASCII range 32~127 and TrueType v40.\nVertical spacing is correct.");
//draw_text(0, 0, "This is text with ASCII range 32~255 and TrueType v40.\nVertical spacing is extremely wrong now.");
//draw_text(0, 0, "This is text with ASCII range 32~255 and TrueType v35.\nVertical spacing is a little bit better but still wrong.");
draw_set_valign(fa_top);
draw_set_halign(fa_left);