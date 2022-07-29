section_x = lerp(section_x, -800 * section_selected, 0.3);

for (var i = 0; i < array_length(sections); i++) {
	var section = sections[i];
	var draw_x = section_x + 800 * i;
	draw_set_font(fntFilesInfo);
	draw_set_halign(fa_center);
	draw_text_color_outline(draw_x + 400, 50, section.name, c_gold, c_gold, c_yellow, c_yellow, 1, c_black);
	
	for (var j = 0; j < array_length(section.options); j++) {
		var option = section.options[j];
		var option_x = draw_x + 200;
		var option_y = 150 + 80 * j;
		draw_set_font(fntFilesButtons);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		option.draw_label(option_x, option_y, ((!fade_start || back) && j == section.selected), (j == section.in_option));
		draw_set_font(fntTitleStart);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		option.draw_option(option_x + 100, option_y);
	}
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}