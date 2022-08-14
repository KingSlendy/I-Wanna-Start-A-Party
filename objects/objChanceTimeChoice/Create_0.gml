vspeed = -4;
gravity = 0.4;
target_x = x;
sprite = null;
index = 0;
flag = 0;

alarms_init(1);

alarm_create(function() {
	switch (objChanceTime.current_flag++) {
		case 0:
			target_x = x - 48;
			break;
		
		case 1:
			target_x = x + 48;
			break;
	}

	if (is_local_turn()) {
		with (objChanceTime) {
			advance_chance_time();
		}
	}
});