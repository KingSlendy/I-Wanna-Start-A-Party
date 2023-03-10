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
						"Good job everyone!\nThe moment of truth is coming close...\nTo see which is worth of being the superstar!",
						new Message("Let's give the winners of the past minigame their Coins!",, results_coins)
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