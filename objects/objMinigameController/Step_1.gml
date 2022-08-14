if (!started && get_player_count(player_check) == global.player_max) {
	alpha -= 0.03;
	
	if (alpha <= 0) {
		alpha = 0;
		started = true;
		alarm_call(0, 1);
	}
}

if (finished) {
	alpha += 0.03;
	
	if (alpha >= 1) {
		alpha = 1;
		finished = false;
		back_to_board();
	}
}

if (!IS_ONLINE && info.is_modes && announcer_started && !info.is_finished && global.actions.back.pressed()) {
	room_goto(rMinigameOverview);
}