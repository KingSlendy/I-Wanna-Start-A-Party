draw_set_alpha(options_alpha);
draw_set_color(c_white);
var options_total_height = options_height * options_total;
var options_x = display_get_gui_width() / 2 - options_width / 2;
var options_y = display_get_gui_height() / 2 - options_total_height / 2 - options_height / 2;

for (var i = 0; i < options_total; i++) {
	var draw_y = options_y + options_height * i;
	draw_box(options_x, draw_y, options_width, options_height, (i == global.choice_selected && options_alpha == 1) ? #B30000 : c_dkgray, c_dkgray);
	var text = new Text(fntDialogue, options[i].text);
	text.draw(options_x + 5, draw_y + 7);
}

draw_set_alpha(1);
