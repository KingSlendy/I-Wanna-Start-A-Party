depth = -9000;
image_xscale = 0;
image_yscale = 0;
sequence = layer_sequence_create("Assets", x, y, seqBoxes);
sequence_instance_override_object(layer_sequence_get_instance(sequence), objBox, id);

function random_roll() {
	var min_roll = 1;
	var max_roll = 10;
	
	switch (instance_number(objTrailerDiceRoll)) {
		case 0: max_roll = 31; break;
		case 1: max_roll = 12; break;
		case 2: max_roll = 30; break;
	}
	
	var previous = roll;
	
	do {
		roll = irandom_range(min_roll, max_roll);
	} until (roll != previous);
}

function let_roll() {
	instance_create_layer(x, y - 46, "Actors", objTrailerDiceRoll, { roll: self.roll });
	audio_play_sound(sndDiceHit, 0, false);
	instance_destroy();
}

roll = 0;
random_roll();
roll_spd = 0.08;

alarms_init(1);

alarm_create(function() {
	random_roll();

	if (layer_sequence_is_finished(sequence)) {
		audio_play_sound(sndDiceRoll, 0, false);
	}

	alarm_call(0, roll_spd);
});

alarm_call(0, roll_spd);