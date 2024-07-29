// New board global variables
// Check line 211 in scrSaveManagement or search fasf (ctrl + shift + F)
global.board_fasf_last5turns_event = false; // Init specual variable to change song in the last 5 turns
global.nusic_board_track_position = 0; // Handle track position when we go back to the board after a minigame

function set_fasf_event(mode = false) {
	global.board_fasf_last5turns_event = mode;
}

function fasf_play_music() {
	music_play(bgmBoardFASFLast5Turns);
	audio_sound_gain(global.music_current, 1, 500);
}

function fasf_save_track_position() {
	print("VAMO AL MINIJUEGO");
	if room == rBoardFASF {
		global.nusic_board_track_position = audio_sound_get_track_position(global.music_current);
		print($"Track position stored ({global.nusic_board_track_position})");
	}
}

function fasf_play_music_from_position(music) {
	music_play(music);
	audio_sound_gain(global.music_current, 0, 0);
	audio_sound_set_track_position(global.music_current, global.nusic_board_track_position);
	print($"Music position loaded ({global.nusic_board_track_position})");
	audio_sound_gain(global.music_current, 1, 500);
}