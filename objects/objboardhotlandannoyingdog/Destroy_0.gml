audio_stop_sound(bgmBoardHotlandAnnoyingDog);
music_resume();

with (focus_player) {
	with (instance_nearest(x, y, objSpaces)) {
		image_index = SpaceType.Blue;
	}
}

board_advance();