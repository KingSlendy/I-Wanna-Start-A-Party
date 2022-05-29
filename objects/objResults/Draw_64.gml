draw_set_font(fntPlayerInfo);
draw_set_color(c_white);

for (var i = 0; i < global.player_max; i++) {
	draw_box(0, 32 * i, 160, 32, player_color_by_turn(i + 1),, 0.8);
	draw_text_outline(5, 32 * i + 5, focus_player_by_turn(i + 1).network_name, c_black);
}
