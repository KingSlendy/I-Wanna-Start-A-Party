if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	if (--cpu_shot_delay[i - 1] == 0) {
		actions.shoot.press();
	}
	
	cpu_shot_delay[i - 1] = max(cpu_shot_delay[i - 1], 0);
}

alarm[11] = 1;