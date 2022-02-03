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