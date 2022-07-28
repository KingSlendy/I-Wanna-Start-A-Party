global.music_current = null;
global.music_previous = null;
global.sound_cursor_move = sndCursorMove;
global.sound_cursor_select = sndCursorSelect;
global.sound_cursor_select2 = sndCursorSelect2;
global.sound_cursor_big_select = sndCursorBigSelect;
global.sound_cursor_back = sndCursorBack;

function music_check() {
	var music = null;
	
	switch (room) {
		case rFiles: music = bgmFiles; break;
		default: break;
	}
	
	music_play(music);
}

function music_play(music, loop = true) {
	global.music_previous = null;
	
	if (global.music_current != null && music != global.music_current && !music_is_same(music)) {
		audio_stop_sound(global.music_current);
	}
	
	music_change(music, loop);
}

function music_change(music, loop = true) {
	if (music != null && !music_is_same(music)) {
		global.music_current = audio_play_sound(music, 0, loop);
	}
}

function music_is_same(music) {
	if (music == null || global.music_current == null) {
		return false;
	}
	
	return (audio_get_name(music) == audio_get_name(global.music_current));
}

function music_stop() {
	if (global.music_current != null) {
		audio_stop_sound(global.music_current);
		audio_sound_gain(global.music_current, 1, 0);
		global.music_current = null;
	}
}

function music_pause() {
	audio_pause_sound(global.music_current);
	global.music_previous = global.music_current;
}

function music_resume() {
	if (global.music_previous != null) {
		global.music_current = global.music_previous;
		audio_resume_sound(global.music_current);
	}
}

function music_fade(time = 1000) {
	audio_sound_gain(global.music_current, 0, time);
}
