if (info.is_finished) {
	exit;
}

if (minigame1vs3_solo().lost) {
	minigame_time_end();
	exit;
}