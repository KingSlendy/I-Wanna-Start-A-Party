if (IS_BOARD) {
	if (!global.board_started) {
		for (var i = 1; i <= global.player_max; i++) {
			var player = focus_player_by_id(i);
			
			with (objPlayerReference) {
				if (reference == 0) {
					player.x = x + 17 + 32 * (i - 1);
					player.y = y + 23;
					break;
				}
			}
		}
	}
	
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
