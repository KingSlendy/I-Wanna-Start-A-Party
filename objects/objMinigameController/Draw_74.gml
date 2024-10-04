if (instance_exists(objCameraSplit4) && objCameraSplit4.draw_names) {
	switch (info.type) {
		case "4vs":
			draw_4vs_squares();
			break;
			
		case "1vs3":
			draw_1vs3_squares();
			break;

		case "2vs2":
			draw_2vs2_squares();
			break;
	}
} else {
	language_set_font(global.fntPlayerInfo);
	draw_set_valign(fa_middle);
	
	for (var i = 0; i < global.player_max; i++) {
		var draw_x, draw_y, text_x, text_y;
		
		if (info.type == "2vs2" && room != rMinigame4vs_Jingle && room != rMinigame4vs_Leap) {
			var set_i = [0, 2, 1, 3];
			var check_i = set_i[i];
		} else {
			var check_i = i;
		}
		
		switch (check_i) {
			case 0:
				draw_x = 18;
				draw_y = 18;
				text_x = draw_x + 20;
				text_y = draw_y;
				break;
				
			case 1:
				draw_x = 800 - 18;
				draw_y = 18;
				text_x = draw_x - 20;
				text_y = draw_y;
				draw_set_halign(fa_right);
				break;
				
			case 2:
				draw_x = 18;
				draw_y = 608 - 18;
				text_x = draw_x + 20;
				text_y = draw_y;
				break;
				
			case 3:
				draw_x = 800 - 18;
				draw_y = 608 - 18;
				text_x = draw_x - 20;
				text_y = draw_y;
				draw_set_halign(fa_right);
				break;
		}

		draw_set_color(c_black);
		draw_circle(draw_x, draw_y, 16, false);
		
		switch (info.type) {
			case "4vs":
			case "1vs3":
				draw_set_color(player_color_by_turn(i + 1));
				break;
				
			case "2vs2": draw_set_color(info.player_colors[i div 2]); break;
		}
		
		draw_circle(draw_x, draw_y, 15, false);
		draw_set_color(c_white);
		
		switch (info.type) {
			case "4vs":
			case "1vs3":
				var player = focus_player_by_turn(i + 1);
				break;
				
			case "2vs2": var player = points_teams[i div 2][i % 2]; break;
		}

		draw_sprite(focus_info_by_id(player.network_id).player_idle_image, 0, draw_x + 2, draw_y + 2);
		draw_player_name(text_x, text_y, player.network_id);
		draw_set_halign(fa_left);
	}
	
	draw_set_valign(fa_top);
}