minigame_start(info, minigame_camera);

if (trial_is_title(INVISI_GAME)) {
	with (objPlayerBase) {
		if (network_id == global.player_id) {
			draw = false;
			break;
		}
	}
}

if (trial_is_title(FLIPPED_WORLD)) {
	for (var i = 0; i < 8; i++) {
		camera_set_view_angle(view_camera[i], 180);
	}
}