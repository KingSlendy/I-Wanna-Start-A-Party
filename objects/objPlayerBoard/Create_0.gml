event_inherited();
skin = get_skin();
first_space = true;
max_speed = 5;
follow_path = null;
can_jump = false;
dice_hit_y = y;

function snap_to_object(obj) {
	y = yprevious;

	while (!place_meeting(x, y - 1, obj)) {
		y--;
	}

	vspeed = 0;
}