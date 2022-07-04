alarm[4] = 0;
var moving = false;

with (objMinigame4vs_Chests_Chest) {
	if (target_switched) {
		moving = true;
		break;
	}
}

if (moving) {
	alarm[5] = 1;
	exit;
}

with (objMinigame4vs_Chests_Chest) {
	switch_target(, target_y + 300);
	selectable = true;
}

current_switch = 0;