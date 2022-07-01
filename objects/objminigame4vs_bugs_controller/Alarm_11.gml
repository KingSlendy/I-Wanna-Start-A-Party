if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
	
	var action = choose(actions.left, actions.right);
	action.press();
}

alarm[11] = get_frames(0.5);