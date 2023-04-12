if (!announcer_started || info.is_finished) {
	exit;
}

with (objPlayerBase) {
	if (door == null) {
		image_alpha = 1;
		frozen = false;
	}
}