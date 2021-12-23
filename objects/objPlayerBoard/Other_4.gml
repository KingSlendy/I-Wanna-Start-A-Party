x = path_get_point_x(global.path_current, global.path_number);
y = path_get_point_y(global.path_current, global.path_number);

if (!global.board_started) {
	x += 64 * (global.player_id - 1);
}