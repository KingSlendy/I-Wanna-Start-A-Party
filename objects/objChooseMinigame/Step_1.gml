if (zoom) {
	objCamera.target_follow = {x: room_width / 2, y: room_height / 2};
} else {
	objCamera.target_follow = null;
}

/*for (var i = 1; i <= global.player_max; i++) {
	focus_player_by_turn(i).visible = false;
}