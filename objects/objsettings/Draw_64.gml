section_x = lerp(section_x, 800 * section_selected, 0.2);

for (var i = 0; i < array_length(sections); i++) {
	var section = sections[i];
	draw_set_font(fntFilesInfo);
	draw_set_halign(fa_center);
	draw_text_color_outline(section_x + 400 + 800 * i, 50, section.name, c_gold, c_gold, c_yellow, c_yellow, 1, c_black);
	
	draw_set_font(fntFilesButtons);
	draw_set_valign(fa_middle);
	
	for (var j = 0; j < array_length(section.options); j++) {
		var option = section.options[j];
		option.draw_label(200, 150 + 80 * j, ((!fade_start || back) && j == section.selected), (j == section.in_option));
	}
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}