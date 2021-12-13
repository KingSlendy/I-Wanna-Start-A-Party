draw_set_color(c_black);

if (space.path_north != null) {
	draw_arrow(objPlayerBoard.x, objPlayerBoard.y - 10, objPlayerBoard.x, objPlayerBoard.y - 60, 3);
}

if (space.path_east != null) {
	draw_arrow(objPlayerBoard.x + 10, objPlayerBoard.y, objPlayerBoard.x + 60, objPlayerBoard.y, 3);
}

if (space.path_west != null) {
	draw_arrow(objPlayerBoard.x - 10, objPlayerBoard.y, objPlayerBoard.x - 60, objPlayerBoard.y, 3);
}

if (space.path_south != null) {
	draw_arrow(objPlayerBoard.x, objPlayerBoard.y + 10, objPlayerBoard.x, objPlayerBoard.y + 60, 3);
}