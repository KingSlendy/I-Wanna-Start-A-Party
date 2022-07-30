draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, (!touched) ? c_white : c_gray, 1);

for (var i = 1; i <= global.player_max; i++) {
	if (focus_player_by_turn(i).last_touched == id) {
		var part_x = 16 * (i % 2 == 0);
		var part_y = 16 * (i > 2);
		draw_sprite_part_ext(sprite_index, image_index, part_x, part_y, 16, 16, x + part_x, y + part_y, 1, 1, player_color_by_turn(i), 1);
	}
}