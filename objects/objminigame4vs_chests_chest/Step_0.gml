x = approach(x, target_x, target_spd * DELTA);
y = approach(y, target_y, target_spd * DELTA);

if (target_switched && x == target_x && y == target_y) {
	target_switched = false;
}