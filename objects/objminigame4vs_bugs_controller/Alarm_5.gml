var min_diff = infinity;

for (var i = 1; i <= global.player_max; i++) {
	with (objMinigame4vs_Bugs_Counting) {
		if (i == network_id) {
			min_diff = min(min_diff, abs(count - other.total_bugs));
			break;
		}
	}
}

with (objMinigame4vs_Bugs_Counting) {
	if (abs(count - other.total_bugs) == min_diff) {
		minigame4vs_points(network_id);
	}
}

minigame_finish();