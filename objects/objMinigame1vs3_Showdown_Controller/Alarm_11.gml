
for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
		
	switch (irandom(2)) {
		case 0: actions.left.press(); break;
		case 1: actions.right.press(); break;
		case 2: actions.jump.press(); break;
	}
}

alarm[11] = get_frames(0.5);