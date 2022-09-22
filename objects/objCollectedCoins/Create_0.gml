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
hide = false;

alarms_init(3);

alarm_create(function() {
	var change = 10000;
	
	while (true) {
		if (change == 1) {
			break;
		}
		
		var left = abs(amount - current);
		
		if (left == change) {
			change /= 10;
			break;
		}
		
		if (left >= change) {
			break;
		}
		
		change /= 10;
	}

	change *= sign(amount);
	coins += change;
	scale = (scale == 1) ? 1.25 : 1;
	audio_play_sound((sign(amount) == 1) ? sndCoinGet : sndCoinLose, 0, false);
	current += change;

	if (current == amount) {
		alarm_call(1, 1);
		exit;
	}

	alarm_call(0, 0.06);
});

alarm_create(function() {
	yt = -20;
	alarm_call(2, 1);
});

alarm_create(function() {
	instance_destroy();
});

alarm_call(0, 0.3);