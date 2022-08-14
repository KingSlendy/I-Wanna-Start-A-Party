if (instance_number(object_index) > 1) {
	with (object_index) {
		if (id != other.id) {
			instance_destroy();
		}
	}
}

depth = -9999;
y = -20;
yt = 20;
coins = global.collected_coins;
amount = 0;
current = 0;
scale = 1;

alarms_init(3);

alarm_create(function() {
	var increase = 1;

	if (amount - current > 100) {
		increase = 100;
	}

	coins += increase;
	scale = (scale == 1) ? 1.25 : 1;
	audio_play_sound(sndCoinGet, 0, false);
	current += increase;

	if (current == amount) {
		alarm_call(1, 1);
		exit;
	}

	alarm_frames(0, 3);
});

alarm_create(function() {
	yt = -20;
	alarm_call(2, 1);
});

alarm_create(function() {
	instance_destroy();
});

alarm_call(0, 1);