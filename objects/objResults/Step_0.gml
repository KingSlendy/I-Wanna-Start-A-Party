if (fade_start) {
	if (!revealed) {
		if (get_player_count(objPlayerParty) == global.player_max) {
			fade_alpha -= 0.01;
			music_play(bgmResults);
	
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
		
				if (global.player_id == 1) {
					start_dialogue([
						language_get_text("PARTY_RESULTS_GOOD_JOB"),
						new Message(language_get_text("PARTY_RESULTS_GIVE_COINS"),, results_coins)
					]);
				}
			}
		}
	} else {
		fade_alpha += 0.03;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			disable_board();
			room_goto(rModes);
		}
	}
}