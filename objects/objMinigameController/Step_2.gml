if (!announcer_started || announcer_finished) {
	exit;
}

with (objPlayerBase) {
	minigame_add_timer(other.info, network_id - 1);
}