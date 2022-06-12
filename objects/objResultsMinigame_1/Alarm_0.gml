if (is_local_turn()) {
	for (var i = 0; i < array_length(info.players_won); i++) {
		var player_won = info.players_won[i];
		change_coins(10, CoinChangeType.Gain, player_info_by_id(player_won).turn);
	}
}

alarm[1] = get_frames(1);