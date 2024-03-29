if (!started && get_player_count(player_type) == global.player_max) {
	fade_alpha -= 0.03 * DELTA;
	
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		started = true;
		
		if (global.trial_info.reference == null) {
			alarm_call(0, 1);
		} else {
			alarm_instant(0);
		}
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

practice_alpha = lerp(practice_alpha, (global.trial_info.reference == null) ? 0.1 : 0, (global.trial_info.reference == null) ? 0.02 : 0.04);

if ((info.is_practice || global.trial_info.reference != null) && global.player_id == 1 && global.actions.misc.pressed()) {
	if (global.trial_info.reference == null) {
		back_to_overview();
	} else {
		retry_trial();
	}
	
	global.actions.misc.consume();
	exit;
}

if (info.is_finished || global.trial_info.reference == null) {
	exit;
}

if (focus_player_by_id(global.player_id).lost) {
	minigame_finish();
}