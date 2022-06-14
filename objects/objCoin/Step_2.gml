if (hspeed > 0 || vspeed > 0) {
	if (instance_place(x, y, focus_player)) {
		audio_play_sound(snd, 0, false);
		instance_destroy();
	}
}