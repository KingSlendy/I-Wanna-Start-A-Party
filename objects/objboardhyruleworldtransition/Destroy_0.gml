music_stop();
global.board_music_track_position = 0;
board_music();

if (final_action != null) {
	final_action();
}