if (global.player_id != 1 || !movable || !hittable) {
	exit;
}

direction = point_direction(other.x, other.y, x, y - 16);
speed = 6;
gravity = 0.4;

alarm_frames(1, 3);