if (info.is_finished) {
	exit;
}

if (minigame_lost_all()) {
	with (objMinigame4vs_Blocks_Block) {
		enabled = false;
		active = false;
		image_blend = c_white;
		alarm_stop(0);
	}
	
	minigame_lost_points();
	minigame_finish();
}