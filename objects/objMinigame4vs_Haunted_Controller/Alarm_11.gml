if (global.player_id != 1) {
	exit;
}

for (var i = 2; i <= global.player_max; i++) {
	var actions = check_player_actions_by_id(i);

	if (actions == null) {
		continue;
	}
		
	if (sign(objMinigame4vs_Haunted_Boo.image_xscale) == 1) {
		actions.right.press();
	} else {
		if (irandom(10) == 0) {
			actions.right.hold(get_frames(0.5));
		}
	}
}

alarm[11] = 1;
