if (!started && get_player_count(player_type) == global.player_max) {
	fade_alpha -= 0.03 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		started = true;
		alarm_call(0, 1);
	}
}

if (finished) {
	fade_alpha += 0.03 * DELTA;
	
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		finished = false;
		back_to_board();
	}
}

practice_alpha = lerp(practice_alpha, 0.3, 0.01);

if (global.player_id == 1 && global.actions.misc.pressed()) {
	back_to_overview();
	exit;
}

if (info.is_finished || global.trial_info.reference == null) {
	exit;
}

if (focus_player_by_id(global.player_id).lost) {
	minigame_finish();
}