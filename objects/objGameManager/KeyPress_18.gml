for (var i = 2; i <= global.player_max; i++) {
	if (!focus_player(i).visible) {
		ai_join(i);
	}
}