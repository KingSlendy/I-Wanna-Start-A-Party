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

function draw_box(x, y, w, h, color) {
	draw_sprite_ext(sprBoxFill, 0, x, y, w, h, 0, color, draw_get_alpha());
	draw_sprite_stretched(sprBoxFrame, 0, x, y, w, h);
}

function draw_coins_price(price) {
	return "{SPRITE,sprCoin,0,0,2,0.6,0.6}" + string(price);
}