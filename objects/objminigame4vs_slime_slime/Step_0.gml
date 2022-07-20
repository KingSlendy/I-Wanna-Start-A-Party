if (objMinigameController.player_turn > 0 && focus_player_by_turn(objMinigameController.player_turn).lost && alarm[1] == -1) {
	alarm[1] = get_frames(1);
}