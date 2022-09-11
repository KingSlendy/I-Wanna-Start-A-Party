draw_y = lerp(draw_y, draw_target_y, 0.3);
var options_y = draw_y;

for (var i = 0; i < array_length(sections); i++) {
	var section = sections[i];
	draw_set_font(fntFilesInfo);
	draw_set_halign(fa_center);
	draw_text_color_outline(400, options_y, section.name, c_gold, c_gold, c_yellow, c_yellow, 1, c_black);
	options_y += 100;
	
	for (var j = 0; j < array_length(section.options); j++) {
		var option = section.options[j];
		
		switch (i) {
			case 0: var option_x = 200; break;
			case 1: var option_x = 250; break;
			case 2: var option_x = 300; break;
		}
		
		draw_set_font(fntFilesButtons);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		option.draw_label(option_x, options_y, ((!fade_start || back) && i == section_selected && j == section.selected), (j == section.in_option));
		draw_set_font(fntTitleStart);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		option.draw_option(option_x + 100, options_y);
		options_y += 60;
	}
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

controls_text.draw(420, 580);