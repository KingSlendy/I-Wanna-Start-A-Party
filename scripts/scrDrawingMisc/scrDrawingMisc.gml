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

function draw_box(x, y, w, h, fill_color, outline_color = c_yellow, fill_alpha = draw_get_alpha(), outline_alpha = draw_get_alpha(), fill_index = 0, stars = false) {
	draw_sprite_stretched_ext(sprBoxFill, fill_index, x, y, w, h, fill_color, fill_alpha);
	draw_sprite_stretched_ext(sprBoxFrame, 0, x, y, w, h, outline_color, outline_alpha);
	
	if (stars) {
		draw_sprite_stretched(sprBoxStars, 0, x, y, w, h)
	}
}

function draw_player_name(x, y, player_id) {
	var font = draw_get_font();
	var valign = draw_get_valign();
	language_set_font(global.fntPlayerName);
	draw_set_valign(fa_middle);
	var name = focus_player_by_id(player_id).network_name;
	
	if (string_length(name) > 5) {
		var scale = remap(string_length(name), 1, 16, 1, 0.3);
	} else {
		var scale = 1;
	}
	
	draw_text_transformed_outline(x, y, name, scale, scale, 0, c_black);
	draw_set_valign(valign);
	language_set_font(font);
}

function draw_text_info(x, y, text, max_width, c1 = c_white, c2 = c_white, c3 = c_white, c4 = c_white, border_color = c_black) {
	var width = string_width(text);
	var scale = min(max_width / width * 0.9, 1);
	draw_text_transformed_color_outline(x, y, text, scale, scale, 0, c1, c2, c3, c4, draw_get_alpha(), border_color);
}

function draw_collected_coins(x, y) {
	var showed_gui = (instance_exists(objCollectedCoins));
	var coins = string((!showed_gui) ? global.collected_coins : objCollectedCoins.coins);
	
	if (showed_gui) {
		objCollectedCoins.hide = true;
	}
	
	language_set_font(global.fntPlayerInfo);
	draw_sprite(sprCoin, 0, x - string_width(coins) / 2 - sprite_get_width(sprCoin) / 2 - 4, y);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(x, y, coins, c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

function draw_coins_price(price = "") {
	return "{SPRITE,sprCoin,0,0,0,0.7,0.7}" + string(price);
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
	
	if (room == rMinigame4vs_Crates) {
		draw_w *= 2;
		draw_h *= 2;
	}

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

function draw_1vs3_squares() {
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
		
		var player = focus_player_by_turn(i + 1);
		
		if (room == rMinigame1vs3_Host && !player.draw) {
			draw_set_color(c_black);
			draw_rectangle(draw_x, draw_y, draw_x + (draw_w - 1), draw_y + (draw_h - 1), false);
		}
		
		draw_box(draw_x, draw_y, draw_w, draw_h, c_white, info.player_colors[(player.network_id != objMinigameController.minigame1vs3_solo().network_id)], 0);
	}
}

function draw_2vs2_squares() {
	var info = global.minigame_info;
	var draw_w = camera_get_view_width(view_camera[0]);
	var draw_h = camera_get_view_height(view_camera[0]);
	
	if (room == rMinigame2vs2_Duos) {
		draw_h *= 2;
	}

	for (var i = 0; i < global.player_max; i++) {
		if (room != rMinigame2vs2_Duos) {
			draw_set_color(info.player_colors[(i >= 2)]);
		} else {
			draw_set_color(info.player_colors[(i > 0)]);
		}
		
		var draw_x = draw_w * (i div 2);
		var draw_y = draw_h * (i % 2);
		draw_box(draw_x, draw_y, draw_w, draw_h, c_white, draw_get_color(), 0);
	}
}

function draw_page(text, desc) {
	return "{COLOR,0000FF}" + text + "{COLOR,FFFFFF}:\n" + desc;
}

function draw_action(action) {
	return "{SPRITE," + sprite_get_name(action.bind()) + ",0,0,0,0.5,0.5}";
}

function draw_action_big(action) {
	return "{SPRITE," + sprite_get_name(action.bind()) + ",0,0,0,0.75,0.75}";
}

function draw_action_small(action) {
	return "{SPRITE," + sprite_get_name(action.bind()) + ",0,0,0,0.35,0.35}";
}

function draw_spotlight(x, y, size) {
	shader_set(shdSpotlight);
	shader_set_uniform_f(shader_get_uniform(shdSpotlight, "u_uPosition"), x, y);
	shader_set_uniform_f(shader_get_uniform(shdSpotlight, "u_uSize"), size);
	var half = size / 2;
	draw_rectangle(x - half, y - half, x + half, y + half, false);
	shader_reset();
}