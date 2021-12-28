if (is_player_turn() && !global.board_started) {
	objPlayerBoard.x = objPlayerBoard.xstart;
}

switch_camera_target(objCamera.target_follow.x, objCamera.target_follow.y).final_action = function() {
	board_start();
}

instance_destroy();