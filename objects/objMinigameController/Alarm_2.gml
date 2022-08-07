var winner_title = "";
var loser_count = 0;

if (array_length(info.players_won) > 0) {
	for (var i = 0; i < global.player_max; i++) {
		loser_count += (info.player_scores[i].points <= 0);
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
	gain_trophy(9);
}

if (!info.is_practice) {
	for (var i = 0; i < array_length(info.players_won); i++) {
		bonus_shine_by_id(BonusShines.MostMinigames).increase_score(info.players_won[i]);
	}
}

show_popup(winner_title,,,,,, 3.5);
alarm[3] = get_frames(4);