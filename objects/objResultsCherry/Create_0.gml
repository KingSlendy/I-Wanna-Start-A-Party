vspeed = 9;
down = false;

alarms_init(2);

alarm_create(function() {
	vspeed = 0;
	var time;

	switch (place) {
		case 4: time = 2; break;
		case 3: time = 3; break;
		case 2: time = 5; break;
	}

	alarm_call(1, time);
});

alarm_create(function() {
	vspeed = 9 * ((down) ? 1 : -1);

	switch (place) {
		case 4: audio_play_sound(sndResultsBang4th, 0, false); break;
		case 3: audio_play_sound(sndResultsBang3rd, 0, false); break;
		case 2: audio_play_sound(sndResultsBang2nd, 0, false); break;
	}
});

alarm_call(0, 0.9);