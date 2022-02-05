function draw_text_outline(x, y, text, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text(x + j, y + i, text);
	    }
	}

	draw_set_color(color);
	draw_text(x, y, text);
}

function draw_text_transformed_outline(x, y, text, xscale, yscale, angle, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text_transformed(x + j, y + i, text, xscale, yscale, angle);
	    }
	}

	draw_set_color(color);
	draw_text_transformed(x, y, text, xscale, yscale, angle);
}

function draw_box(x, y, w, h, fill_color, outline_color = c_yellow, fill_alpha = draw_get_alpha(), outline_alpha = draw_get_alpha()) {
	draw_sprite_ext(sprBoxFill, 0, x, y, w, h, 0, fill_color, fill_alpha);
	draw_sprite_stretched_ext(sprBoxFrame, 0, x, y, w, h, outline_color, outline_alpha);
}

function draw_coins_price(price) {
	return "{SPRITE,sprCoin,0,0,2,0.6,0.6}" + string(price);
}

function draw_option_afford(option, check1, check2) {
	var addition = "";
	
	if (check1) {
		if (check2) {
			addition += "{RAINBOW}{WAVE}";
		}
	} else {
		addition += "{COLOR,383838}";
		
		if (check2) {
			addition += "{COLOR,000066}{WAVE}";
		}
	}
	
	return addition + option;
}