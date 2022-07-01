var player = focus_player_by_id(global.player_id);

if ((x < 400 && player.x < 400) || (x > 400 && player.x > 400)) {
	if (type == 2) {
		objMinigameController.trophy_small--;
	}

	if (type == -2) {
		objMinigameController.trophy_gordos--;
	}
}

instance_destroy();