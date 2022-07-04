x = approach(x, target_x, target_spd);
y = approach(y, target_y, target_spd);

if (target_switched && x == target_x && y == target_y) {
	target_switched = false;
}