if (snd != null) {
	if (!audio_is_playing(snd)) {
		with (objTheGuyMouth) {
			image_speed = 0;
			image_index = 0;
		}
		snd = null;
	} else {
		objTheGuyMouth.image_speed = 0.5;
	}
}
