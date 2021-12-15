global.music_current = null;

function music_check() {
	var music = null;
	
	switch (room) {
		//case rBoardSMW: music = bgmBoardSMW; break;
		default: break;
	}
	
	music_play(music);
}

function music_play(music, loop = true) {
	if (global.music_current != null) {
		audio_stop_sound(global.music_current);
	}
	
	if (music != null) {
		global.music_current = audio_play_sound(music, 0, loop);
	}
}