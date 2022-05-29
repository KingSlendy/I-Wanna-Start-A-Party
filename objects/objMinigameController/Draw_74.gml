if (instance_exists(objCameraSplit4)) {
	switch (info.type) {
		case "4vs":
			draw_4vs_squares();
			break;
			
		case "1vs3":
			break;
			
		case "2vs2":
			draw_2vs2_squares(info);
			break;
	}
} else {
	draw_set_font(fntPlayerInfo);
	draw_set_valign(fa_middle);
	
	for (var i = 0; i < global.player_max; i++) {
		var draw_x, draw_y, text_x, text_y;
		
		switch (i) {
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
		draw_set_color(player_color_by_turn(i + 1));
		draw_circle(draw_x, draw_y, 15, false);
		draw_set_color(c_white);
		var player = focus_player_by_turn(i + 1);
		draw_sprite(get_skin_pose_object(player, "Idle"), 0, draw_x + 2, draw_y + 2);
		draw_text_outline(text_x, text_y, player.network_name, c_black);
		draw_set_halign(fa_left);
	}
	
	draw_set_valign(fa_top);
}
