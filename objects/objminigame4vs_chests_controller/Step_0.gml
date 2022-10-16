var all_selected = true;

with (objMinigame4vs_Chests_Chest) {
	if (!selectable || selected == -1 || image_index == 1) {
		all_selected = false;
		break;
	}
}

if (all_selected) {
	minigame_time_end();
} else if (!chest_show) {
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