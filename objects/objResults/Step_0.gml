if (fade_start) {
	if (!revealed) {
		if (get_player_count(objPlayerParty) == global.player_max) {
			fade_alpha -= 0.01;
			music_play(bgmResults, true);
	
			if (fade_alpha <= 0) {
				fade_alpha = 0;
				fade_start = false;
		
				if (global.player_id == 1) {
					start_dialogue([
						"Good job everyone!\nThe moment of truth is coming close...\nTo see which is worth of being the superstar!",
						new Message("Let's give the winners of the past minigame their coins!",, results_coins)
					]);
				}
			}
		}
	} else {
		fade_alpha += 0.03;
		
		if (fade_alpha >= 1) {
			fade_alpha = 1;
			fade_start = false;
			global.games_played++;
			increase_collected_coins(player_info_by_id(global.player_id).shines * 100 + 100);
			variable_struct_remove(global.board_games, global.game_id);
			save_file();
			disable_board();
			room_goto(rModes);
		}
	}
}
