if (info.is_finished) {
	exit;
}

var lost_count = 0;

with (objPlayerBase) {
	lost_count += lost;
}

if (lost_count >= global.player_max - 1) {
	minigame_time_end();
}