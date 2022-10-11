if (global.player_id != 1 || !movable || !hittable) {
	exit;
}

var dir = point_direction(other.x, other.y, x, y - 16);
hspeed = lengthdir_x(6, (other.xscale == 1) ? 0 : 180);
vspeed = lengthdir_y(6, dir);
gravity = 0.4;

alarm_frames(1, 6);