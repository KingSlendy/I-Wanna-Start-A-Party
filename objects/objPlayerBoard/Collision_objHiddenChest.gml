if (!is_local_turn()) {
	return;
}

y = yprevious;

while (!place_meeting(x, y - 1, other)) {
	y--;
}

vspeed = 0;
open_chest();