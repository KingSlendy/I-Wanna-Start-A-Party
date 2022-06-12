for (var i = 0; i < array_length(global.minigame_info.players_won); i++) {
	var player_won = global.minigame_info.players_won[i];
	change_coins(10, CoinChangeType.Gain, player_info_by_id(player_won).turn);
}

alarm[2] = get_frames(3.3);