if (info.is_finished) {
	exit;
}

if (minigame4vs_get_points(minigame1vs3_solo().network_id) >= coin_max_win) {
	minigame_finish();
}