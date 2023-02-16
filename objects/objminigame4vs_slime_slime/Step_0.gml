if (objMinigameController.player_turn > 0 && focus_player_by_turn(objMinigameController.player_turn).lost && alarm_is_stopped(1)) {
	alarm_stop(0);
	alarm_call(1, 1);
	
	with (objMinigameController) {
		alarm_stop(10);
	}
}