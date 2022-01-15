for (var i = 2; i <= global.player_max; i++) {
	if (!focus_player_by_id(i).visible) {
		ai_join(i);
	}
}