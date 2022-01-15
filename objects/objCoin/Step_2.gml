if (vspeed > 0) {
	var focus = focused_player();

	if (instance_place(x, y, focus)) {
		audio_play_sound(sndCoinGet, 0, false);
		instance_destroy();
	}
}