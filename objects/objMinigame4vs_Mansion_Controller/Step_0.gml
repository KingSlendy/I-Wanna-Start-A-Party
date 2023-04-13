if (!announcer_started || info.is_finished) {
	exit;
}

with (objPlayerBase) {
	if (!is_player_local(network_id)) {
		continue;
	}
	
	if (door == null) {
		image_alpha = 1;
		frozen = false;
	}
}