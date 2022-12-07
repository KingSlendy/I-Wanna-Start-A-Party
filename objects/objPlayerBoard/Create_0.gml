event_inherited();
network_mode = PlayerDataMode.Basic;
skin = get_skin();
max_speed = 6;
follow_path = null;
can_jump = false;
has_hit = false;
dice_hit_y = y;
alpha_target = 1;

function snap_to_object(obj) {
	y = yprevious;

	while (!place_meeting(x, y - 1, obj)) {
		y--;
	}

	vspeed = 0;
}