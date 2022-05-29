if (minigame_time != -1) {
	var w = 100;
	var h = 32;
	var xx = display_get_gui_width() / 2 - w / 2;
	var yy = display_get_gui_height();
	draw_box(xx, yy - h, w, h, c_dkgray, c_yellow);
	draw_set_font(fntDialogue);
	
	if (minigame_time > 5) {
		draw_set_color(c_yellow);
	} else {
		draw_set_color(c_red);
	}
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(xx + w / 2, yy - h / 2, string(minigame_time), c_black);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}

if (points_draw) {
	var colors;
	
	if (array_length(points_teams) == 4) {
		colors = [c_blue, c_red, c_green, c_yellow];
	} else {
		colors = info.player_colors;
	}
	
	for (var i = 0; i < array_length(points_teams); i++) {
		var xx = 274 + 140 * i;
		var yy = 0;
		draw_box(xx, yy, 110, 32, colors[i], c_white);
		draw_set_font(fntDialogue);
	
		var team = points_teams[i];
		var points = 0;
	
		for (var j = 0; j < array_length(team); j++) {
			var player = team[j];
			points += info.player_scores[player.network_id - 1].points;
			draw_sprite(get_skin_pose_object(player, "Idle"), 0, xx + 95 - 20 * j, yy + 18);
		}
	
		draw_set_color(c_white);
		
		if (points_number) {
			draw_text_outline(xx + 15, yy + 5, string(points), c_black);
		}
	}
}
