if (info.is_finished) {
	exit;
}

if (minigame1vs3_lost()) {
	minigame_time_end();
}