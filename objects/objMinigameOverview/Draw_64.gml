draw_set_font(fntMinigameOverviewTitle);
draw_set_color(c_orange);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_color_outline(400, 50, info.reference.title, c_red, c_red, c_fuchsia, c_fuchsia, 1, c_black);
draw_set_valign(fa_top);
draw_sprite(info.reference.portrait, 0, 400, 192);
draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

var index = 0;

switch (info.type) {
	case "4vs":
		var circle_y = 340;
	
		for (var i = 1; i <= global.player_max; i++) {
			var player_info = focus_info_by_turn(i);
			var circle_x = 160 + 160 * (player_info.player_info.turn - 1);
			draw_sprite(sprMinigameOverview_Circles, player_info.player_info.turn - 1, circle_x, circle_y);
			draw_sprite_ext(player_info.player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
			draw_set_color((player_info.player_info.network_id == 1) ? c_yellow : c_white);
			draw_player_name(circle_x, circle_y + 40, player_info.player_info.network_id);
		}
		break;
		
	case "1vs3":
		var circle_x = 160;
		var circle_y = 192;
		
		for (var i = 1; i <= global.player_max; i++) {
			var player_info = focus_info_by_turn(i);
			
			if (player_info.player_info.space == info.player_colors[1]) {
				draw_sprite(sprMinigameOverview_Circles, info.player_colors[1] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_info.player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
				draw_set_color((player_info.player_info.network_id == 1) ? c_yellow : c_white);
				draw_player_name(circle_x, circle_y + 40, player_info.player_info.network_id);
			}
		}
		
		circle_x = 640;
	
		for (var i = 1; i <= global.player_max; i++) {
			var player_info = focus_info_by_turn(i);
			
			if (player_info.player_info.space == info.player_colors[0]) {
				circle_y = 96 + 96 * index++;
				draw_sprite(sprMinigameOverview_Circles, info.player_colors[0] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_info.player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
				draw_set_color((player_info.player_info.network_id == 1) ? c_yellow : c_white);
				draw_player_name(circle_x, circle_y + 40, player_info.player_info.network_id);
			}
		}
		break;
		
	case "2vs2":
		var circle_x = 160;
		var circle_y = 128;

		for (var i = 1; i <= global.player_max; i++) {
			var player_info = focus_info_by_turn(i);
			
			if (player_info.player_info.space == info.player_colors[0]) {
				circle_y = 128 + 128 * index++;
				draw_sprite(sprMinigameOverview_Circles, info.player_colors[0] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_info.player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
				draw_set_color((player_info.player_info.network_id == 1) ? c_yellow : c_white);
				draw_player_name(circle_x, circle_y + 40, player_info.player_info.network_id);
			}
		}

		var circle_x = 640;
		index = 0;
		
		for (var i = 1; i <= global.player_max; i++) {
			var player_info = focus_info_by_turn(i);
			
			if (player_info.player_info.space == info.player_colors[1]) {
				circle_y = 128 + 128 * index++;
				draw_sprite(sprMinigameOverview_Circles, other.info.player_colors[1] != c_blue, circle_x, circle_y);
				draw_sprite_ext(player_info.player_idle_image, 0, circle_x, circle_y - 10, 2, 2, 0, c_white, 1);
				draw_set_color((player_info.player_info.network_id == 1) ? c_yellow : c_white);
				draw_player_name(circle_x, circle_y + 40, player_info.player_info.network_id);
			}
		}
		break;
}

draw_set_halign(fa_left);
draw_box(75, 400, 500, 200, c_blue, c_white, 1, 1);
instructions[instructions_page].set(info.reference.instructions[instructions_page]);
instructions[instructions_page].draw(85, 410);
pages_text.set(draw_action_small(global.actions.left) + draw_action_small(global.actions.right) + " {COLOR,FFFFFF}Page (" + string(instructions_page + 1) + "/" + string(array_length(instructions)) + ")");
pages_text.draw(410, 570);
var text = new Text(fntDialogue);

for (var i = 0; i < array_length(choice_texts); i++) {
	var option_x = 615;
	var option_y = 400 + 45 * i;
	draw_box(option_x, option_y, 130, 40, (i == option_selected) ? c_ltgray : c_dkgray, c_white,,, 1);
	text.set(draw_option_afford(choice_texts[i], true, (i == option_selected)));
	text.draw(option_x + 17, option_y + 6); 
}

draw_set_color(c_white);
var label = draw_action_small(global.actions.jump) + " {COLOR,00FFFF}Select\n" + draw_action_small(global.actions.up) + draw_action_small(global.actions.down) + " Mode";

if (info.is_minigames) {
	label += "\n" + draw_action_small(global.actions.shoot) + " Back";
}

controls_text.set(label);
controls_text.draw(620, 500);