if (info.is_practice) {
	draw_set_alpha(practice_alpha);
	practice_text.set(language_get_text("MINIGAMES_EXIT_PRACTICE", ["{Misc key}", draw_action_big(global.actions.misc)]));
	practice_text.draw(150, 280,,, c_orange, c_orange, c_yellow, c_yellow);
	draw_set_alpha(1);
}

if (minigame_time != -1 && minigame_time <= 60) {
	var w = 100;
	var h = 32;
	
	switch (minigame_time_halign) {
		case fa_left: var xx = 0; break;
		case fa_center: var xx = display_get_gui_width() / 2 - w / 2; break;
		case fa_right: var xx = display_get_gui_width() - w; break;
	}
	
	switch (minigame_time_valign) {
		case fa_top: var yy = h; break;
		case fa_middle: var yy = display_get_gui_height() / 2 + h / 2; break;
		case fa_bottom: var yy = display_get_gui_height(); break;
	}
	
	if (room == rMinigame1vs3_Kardia && minigame_time_valign == fa_middle) {
		yy += 64;
	}
	
	draw_box(xx, yy - h, w, h, c_dkgray, c_white);
	language_set_font(global.fntDialogue);
	
	if (minigame_time > 5) {
		draw_set_color(c_yellow);
	} else {
		draw_set_color(c_red);
	}
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(xx + w / 2, yy - h / 2 + 2, string(minigame_time), c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

if (points_draw) {
	var is_4vs = (array_length(points_teams) == 4);
	var is_1vs3_coins = (room == rMinigame1vs3_Coins);
	
	for (var i = 0; i < array_length(points_teams); i++) {
		if (is_4vs) {
			var xx = 170 + 120 * i;
		} else {
			if (!is_1vs3_coins) {
				var xx = 245 + 180 * i;
			} else {
				var xx = 350 + 180 * i;
			}
		}
		
		var yy = 0;
		
		if (minigame_camera == CameraMode.Split4) {
			var camera = view_camera[0];
			var width = camera_get_view_width(camera);
			var height = camera_get_view_height(camera);
			
			switch (room) {
				case rMinigame4vs_Crates:
					width *= 2;
					height *= 2;
					break;
					
				case rMinigame4vs_Karts:
					width /= 2;
					height /= 2;
					break;
			}
			
			var surf_x = width * (i % 2);
			var surf_y = height * (i div 2);
			
			switch (i) {
				case 0:
					xx = surf_x + 20;
					yy = surf_y + 16 + 12;
					break;
					
				case 1:
					xx = surf_x + width - 120;
					yy = surf_y + 16 + 12;
					break;
					
				case 2:
					xx = surf_x + 20;
					yy = surf_y + height - 16 - 44;
					break;
				
				case 3:
					xx = surf_x + width - 120;
					yy = surf_y + height - 16 - 44;
					break;
			}
		}
		
		draw_box(xx, yy, (is_4vs || is_1vs3_coins) ? 100 : 130, 34, (is_4vs) ? player_color_by_turn(i + 1) : info.player_colors[i], c_white);
		language_set_font(global.fntDialogue);
	
		var team = points_teams[i];
		var points = 0;
	
		for (var j = 0; j < array_length(team); j++) {
			var player = team[j];
			points += info.player_scores[player.network_id - 1].points;
			draw_sprite(focus_info_by_id(player.network_id).player_idle_image, 0, xx + ((is_4vs || is_1vs3_coins) ? 75 : 105) - 20 * j, yy + 19);
		}
	
		draw_set_color(c_white);
		
		if (points_number) {
			draw_text_outline(xx + 15, yy + 5, string(points), c_black);
		}
		
		if (is_1vs3_coins) {
			break;
		}
	}
}