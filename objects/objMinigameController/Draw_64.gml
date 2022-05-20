if (minigame_time != -1) {
	var w = 100;
	var h = 32;
	var xx = display_get_gui_width() / 2;
	var yy = display_get_gui_height();
	draw_set_color(c_gray);
	draw_roundrect(xx - w / 2, yy - h, xx + w / 2, yy, false);
	draw_set_font(fntDialogue);
	
	if (minigame_time > 5) {
		draw_set_color(c_orange);
	} else {
		draw_set_color(c_red);
	}
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_outline(xx, yy - h / 2, string(minigame_time), c_black);
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
		var x1 = 10 + 140 * i;
		var y1 = 0;
		var x2 = x1 + 110;
		var y2 = 32;
		draw_set_color(colors[i]);
		draw_roundrect(x1, y1, x2, y2, false);
		draw_set_font(fntDialogue);
	
		var team = points_teams[i];
		var points = 0;
	
		for (var j = 0; j < array_length(team); j++) {
			var player = team[j];
			points += info.player_scores[player.network_id - 1].points;
			draw_sprite(get_skin_pose_object(player, "Idle"), 0, x1 + 100 - 20 * j, y1 + 20);
		}
	
		draw_set_color(c_white);
		draw_text_outline(x1 + 15, y1 + 5, string(points), c_black);
	}
}
