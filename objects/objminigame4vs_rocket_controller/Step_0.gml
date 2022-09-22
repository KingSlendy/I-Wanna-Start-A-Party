if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	minigame_lost_points();
	minigame_finish();
	
	if (focus_player_by_id(global.player_id).hp == 3) {
		achieve_trophy(44);
	}
}