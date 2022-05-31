if (global.board_started) {
	for (var i = 1; i <= global.player_max; i++) {
		var player = focus_player_by_turn(i);
		player.depth = (global.player_turn == i) ? -10 : 0;
	}
}
