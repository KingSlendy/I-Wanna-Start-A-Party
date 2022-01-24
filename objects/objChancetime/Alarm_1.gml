music_stop();
music_resume();
audio_sound_gain(global.music_current, 1, 0);

if (is_local_turn()) {
	turn_next();
}

instance_destroy();