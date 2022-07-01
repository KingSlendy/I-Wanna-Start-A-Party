if (global.player_id == 1) {
	var players = bonus.max_players();

	for (var i = 0; i < array_length(players); i++) {
		change_shines(1, ShineChangeType.Spawn, player_info_by_id(players[i]).turn).final_action = null;
	}

	alarm[1] = get_frames(3);
}