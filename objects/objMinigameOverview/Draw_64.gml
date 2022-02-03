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