draw_set_font(fntPopup);
draw_set_color(c_orange);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_outline(400, 50, info.reference.title, c_black);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_sprite(sprMinigameOverview_Preview, 0, 400, 192);

var index = 0;

switch (info.type) {
	case "4vs":
		var circle_y = 352;
	
		with (objPlayerInfo) {
			var circle_x = 160 + 160 * (player_info.turn - 1);
			draw_sprite(sprMinigameOverview_Circles, player_info.turn - 1, circle_x, circle_y);
			draw_sprite_ext(player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
		}
		break;
		
	case "1vs3":
		var circle_x = 160;
		var circle_y = 192;
		
		with (objPlayerInfo) {
			if (player_info.space == other.info.player_colors[1]) {
				draw_sprite(sprMinigameOverview_Circles, other.info.player_colors[1] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
			}
		}
		
		circle_x = 640;
	
		with (objPlayerInfo) {
			if (player_info.space == other.info.player_colors[0]) {
				circle_y = 96 + 96 * index++;
				draw_sprite(sprMinigameOverview_Circles, other.info.player_colors[0] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
			}
		}
		break;
		
	case "2vs2":
		var circle_x = 160;
		var circle_y = 128;

		with (objPlayerInfo) {
			if (player_info.space == other.info.player_colors[0]) {
				circle_y = 128 + 128 * index++;
				draw_sprite(sprMinigameOverview_Circles, other.info.player_colors[0] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
			}
		}

		var circle_x = 640;
		index = 0;
		
		with (objPlayerInfo) {
			if (player_info.space == other.info.player_colors[1]) {
				circle_y = 128 + 128 * index++;
				draw_sprite(sprMinigameOverview_Circles, other.info.player_colors[1] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
			}
		}
		break;
}

draw_box(75, 400, 500, 200, c_green);
instructions[instructions_page].draw(85, 410);
var text = new Text(fntDialogue);

for (var i = 0; i < array_length(choice_texts); i++) {
	var option_x = 615;
	var option_y = 400 + 45 * i;
	draw_box(option_x, option_y, 130, 40, (i == option_selected) ? c_gray : c_dkgray);
	text.set(draw_option_afford(choice_texts[i], true, (i == option_selected)));
	text.draw(option_x + 10, option_y + 6); 
}

draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);