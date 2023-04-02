try {
	player_info_by_turn().pokemon = sprite;

	if (pokemon.sound != null) {
		audio_play_sound(pokemon.sound, 0, false);
	}
} catch (ex) {
	log_error(ex);
}

board_advance();