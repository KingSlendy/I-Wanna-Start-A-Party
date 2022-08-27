draw_self();

if (is_player) {
	with (objMinigameController.points_teams[0][player_num]) {
		draw_sprite_ext(sprite_index, 0, other.x + 16, other.bbox_bottom - 9, 1, 1, 0, c_white, 1);
	}
}