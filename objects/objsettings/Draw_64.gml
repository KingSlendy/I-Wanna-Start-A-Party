if (!draw) {
	exit;
}

draw_x = lerp(draw_x, draw_target_x, 0.3);
draw_y = lerp(draw_y, draw_target_y, 0.3);
var options_y = draw_y;

for (var i = 0; i < array_length(sections); i++) {
	var section = sections[i];
	language_set_font(global.fntFilesInfo);
	draw_set_halign(fa_center);
	draw_text_color_outline(draw_x, options_y, section.text, c_gold, c_gold, c_yellow, c_yellow, draw_get_alpha(), c_black);
	options_y += 100;
	
	for (var j = 0; j < array_length(section.options); j++) {
		var option = section.options[j];
		
		switch (i) {
			case 0: var option_x = 200; break;
			case 1: var option_x = 180; break;
			case 2: var option_x = 140; break;
		}
		
		language_set_font(global.fntFilesButtons);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		option.draw_label(draw_x - option_x, options_y, ((!fade_start || back) && i == section_selected && j == section.selected), (j == section.in_option));
		language_set_font(global.fntTitleStart);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		option.draw_option(draw_x - option_x + 100, options_y);
		options_y += 60;
	}
	
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

if (room == rSettings) {
	controls_text.set(draw_action_small(global.actions.jump) + " " + language_get_text("WORD_GENERIC_MENU_CHOOSE") + "   " + draw_action_small(global.actions.left) + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + draw_action_small(global.actions.right) + " " + language_get_text("WORD_GENERIC_MENU_MOVE") + "    " + draw_action_small(global.actions.shoot) + " " + language_get_text("WORD_GENERIC_MENU_BACK"));
	controls_text.draw(420, 580);
}