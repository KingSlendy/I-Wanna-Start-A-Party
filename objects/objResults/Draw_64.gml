language_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	var player = focus_player_by_id(i + 1);
	var box_w = 110;
	var box_h = 32;
	var box_x = player.x - box_w / 2;
	var box_y = display_get_gui_height() - box_h;
	draw_box(box_x, box_y, box_w, box_h, player_color_by_turn(i + 1), c_white, 0.8,, 1);
	draw_player_name(box_x + 20, box_y + box_h / 2 + 2, i + 1);
}