if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	minigame_lost_points();
	minigame_finish();
}