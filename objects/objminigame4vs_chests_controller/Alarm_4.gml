var moving = false;

with (objMinigame4vs_Chests_Chest) {
	if (target_switched) {
		moving = true;
		break;
	}
}

alarm[4] = 1;

if (moving) {
	exit;
}

var switches = chest_switches[current_switch];
var chests = [null, null];

with (objMinigame4vs_Chests_Chest) {
	if (n == switches[0]) {
		chests[0] = id;
	}
	
	if (n == switches[1]) {
		chests[1] = id;
	}
}

with (chests[0]) {
	switch_target(chests[1].x, chests[1].y);
}

with (chests[1]) {
	switch_target(chests[0].x, chests[0].y);
}

current_switch++;
audio_play_sound(sndMinigame4vs_Chests_Move, 0, false);