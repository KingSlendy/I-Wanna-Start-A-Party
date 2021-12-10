if (towards_start) {
	x += sign(towards_start_x - x) * max_speed;
	y += sign(towards_start_y - y) * max_speed;
	
	if (point_distance(x, y, towards_start_x, towards_start_y) < max_speed) {
		x = towards_start_x;
		y = towards_start_y;
		towards_start = false;
		global.board_started = true;
	}
}