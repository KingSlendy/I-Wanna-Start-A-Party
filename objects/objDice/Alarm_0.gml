random_roll();

if (layer_sequence_is_finished(sequence)) {
	audio_play_sound(sndDiceRoll, 0, false);
}

alarm[0] = roll_spd;