var winner_title = "";

switch (info.type) {
	case "4vs":
		var loser_count = 0;
		
		for (var i = 0; i < global.player_max; i++) {
			if (info.player_scores[i].points <= 0) {
				loser_count++;
			}
		}
	
		if (loser_count < global.player_max) {
			for (var i = 0; i < array_length(info.players_won); i++) {
				var player = focus_player_by_id(info.players_won[i]);
				winner_title += player.network_name + "\n";
			}
		
			winner_title += "WON";
			music_play(bgmMinigameWin, false);
			audio_play_sound((array_length(info.players_won) == 1) ? sndMinigameWinner : sndMinigameWinners, 0, false);
		} else {
			info.players_won = [];
			winner_title = "TIE";
			music_play(bgmMinigameTie, false);
			audio_play_sound(sndMinigameTie, 0, false);
		}
		break;
		
	case "1vs3":
	case "2vs2":
		if (info.color_won != c_white) {
			winner_title = (info.color_won == c_blue) ? "BLUE TEAM\nWON" : "RED TEAM\nWON";
			music_play(bgmMinigameWin, false);
			audio_play_sound(sndMinigameWinner, 0, false);
		} else {
			winner_title = "TIE";
			music_play(bgmMinigameTie, false);
			audio_play_sound(sndMinigameTie, 0, false);
		}
		break;
}

show_popup(winner_title,,,,,, 3.5);
alarm[3] = get_frames(4);