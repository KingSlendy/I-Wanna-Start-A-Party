if (instance_exists(objStatChange)) {
	alarm[7] = 1;
	exit;
}

music_stop();
music_resume();
audio_sound_gain(global.music_current, 1, 0);

if (rotate_turn) {
	turn_next();
}

instance_destroy(objTheGuyHead);
instance_destroy(objTheGuyEye);
instance_destroy();
