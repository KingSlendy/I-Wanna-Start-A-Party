if (vspeed > 0) {
	var focus = focused_player_turn();

	if (instance_place(x, y, focus)) {
		audio_play_sound(sndCoinGet, 0, false);
		instance_destroy();
	}
}