if (global.player_id == 1) {
	var players = bonus.max_players();

	for (var i = 0; i < array_length(players); i++) {
		change_shines(1, ShineChangeType.Spawn, players[i]).final_action = null;
	}

	alarm[1] = get_frames(3);
}