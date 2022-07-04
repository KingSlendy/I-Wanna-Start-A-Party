depth = 299;
target_x = x;
target_y = y;
target_spd = 10;
target_switched = false;
coins = 0;
total = 0;
selectable = false;
selected = -1;

function switch_target(new_x = null, new_y = null) {
	if (new_x != null) {
		target_x = new_x;
	}
	
	if (new_y != null) {
		target_y = new_y;
	}
	
	target_switched = true;
}