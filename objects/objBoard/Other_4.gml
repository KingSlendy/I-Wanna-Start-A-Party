if (IS_BOARD) {
	var target_follow = null;

	with (objPlayerReference) {
		if (reference == 1) {
			target_follow = id;
			break;
		}
	}

	camera_start_follow(target_follow, objCameraBoard);
	
	if (global.minigame_info.is_finished) {
		instance_create_layer(0, 0, "Managers", objResultsMinigame);
	}
}