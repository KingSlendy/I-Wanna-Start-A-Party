if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	minigame_time_end();
}