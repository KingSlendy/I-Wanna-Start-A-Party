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

function draw_text_ext_outline(x, y, text, sep, w, border_color) {
	var color = draw_get_color();
	draw_set_color(border_color);

	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text_ext(x + j, y + i, text, sep, w);
	    }
	}

	draw_set_color(color);
	draw_text_ext(x, y, text, sep, w);
}

function draw_text_color_outline(x, y, text, c1, c2, c3, c4, alpha, border_color) {
	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text_color(x + j, y + i, text, border_color, border_color, border_color, border_color, alpha);
	    }
	}

	draw_text_color(x, y, text, c1, c2, c3, c4, alpha);
}

function draw_text_transformed_color_outline(x, y, text, xscale, yscale, angle, c1, c2, c3, c4, alpha, border_color) {
	for (var i = -1; i < 2; i++) {
	    for (var j = -1; j < 2; j++) {
	        draw_text_transformed_color(x + j, y + i, text, xscale, yscale, angle, border_color, border_color, border_color, border_color, alpha);
	    }
	}

	draw_text_transformed_color(x, y, text, xscale, yscale, angle, c1, c2, c3, c4, alpha);
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
	draw_sprite_stretched_ext(sprBoxFill, 0, x, y, w, h, fill_color, fill_alpha);
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

function draw_4vs_squares() {
	var draw_w = camera_get_view_width(view_camera[0]);
	var draw_h = camera_get_view_height(view_camera[0]);

	for (var i = 0; i < global.player_max; i++) {
		switch (objCameraSplit4.mode) {
			case 0: //Full
				var draw_x = draw_w * (i % 2);
				var draw_y = draw_h * (i div 2);
				break;
			
			case 1: //Vertical
				var draw_x = draw_w * i;
				var draw_y = 0;
				break;
			
			case 2: //Horizontal
				var draw_x = 0;
				var draw_y = draw_h * i;
				break;
		}
		
		draw_box(draw_x, draw_y, draw_w, draw_h, c_white, player_color_by_turn(i + 1), 0);
	}
}

function draw_2vs2_squares(info) {
	var draw_w = camera_get_view_width(view_camera[0]);
	var draw_h = camera_get_view_height(view_camera[0]);

	for (var i = 0; i < global.player_max; i++) {
		draw_set_color(info.player_colors[(i >= 2)]);
		var draw_x = draw_w * (i div 2);
		var draw_y = draw_h * (i % 2);
		draw_box(draw_x, draw_y, draw_w, draw_h, c_white, draw_get_color(), 0);
	}
}

function draw_action(action) {
	return "{SPRITE," + sprite_get_name(bind_to_key(action.button)) + ",0,0,0,0.5,0.5}";
}

function draw_action_big(action) {
	return "{SPRITE," + sprite_get_name(bind_to_key(action.button)) + ",0,0,0,0.75,0.75}";
}

function draw_action_small(action) {
	return "{SPRITE," + sprite_get_name(bind_to_key(action.button)) + ",0,0,0,0.35,0.35}";
}
