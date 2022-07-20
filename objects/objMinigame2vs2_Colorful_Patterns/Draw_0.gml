for (var r = 0; r < pattern_rows; r++) {
	for (var c = 0; c < pattern_cols; c++) {
		pattern_grid[r][c].draw(x + c * 32, y + r * 32);
	}
}

if (pattern_player_ids != null) {
	for (var i = 0; i < 2; i++) {
		draw_sprite_ext(sprMinigame2vs2_Colorful_Select, 0, x + pattern_col_selected[i] * 32 - 1, y + pattern_row_selected[i] * 32 - 1, 1, 1, 0, (!pattern_selected[i]) ? player_color_by_turn(player_info_by_id(pattern_player_ids[i]).turn) : c_white, 1);
	}
}

for (var i = 0; i < 4; i++) {
	draw_sprite(sprMinigame2vs2_Colorful_Round, (i < pattern_round), x + 75 * i, 320);
}