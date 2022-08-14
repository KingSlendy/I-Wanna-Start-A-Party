var all_selected = true;

with (objMinigame4vs_Chests_Chest) {
	if (!selectable || selected == -1 || image_index == 1) {
		all_selected = false;
		break;
	}
}

if (all_selected) {
	if (alarm_is_stopped(6)) {
		alarm_call(6, 1);
	}
} else {
	alarm_stop(6);
}

if (chest_started && !info.is_finished) {
	with (objPlayerBase) {
		frozen = false;
	
		with (objMinigame4vs_Chests_Chest) {
			if (selected == other.network_id) {
				other.frozen = true;
				break;
			}
		}
	}
}