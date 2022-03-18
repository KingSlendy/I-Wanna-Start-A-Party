if (IS_BOARD) {
	var target_follow = null;

	with (objPlayerReference) {
		if (reference == 1) {
			target_follow = id;
			break;
		}
	}

	camera_start_follow(target_follow, objCameraBoard);
}

if (global.minigame_info.is_finished) {
	minigame_info_reset();
	from_minigame = true;
	from_minigame_alpha = 1;
}