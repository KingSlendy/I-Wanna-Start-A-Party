vspeed = -4;
gravity = 0.4;
sprite = null;
index = 0;
flag = 0;

alarms_init(1);

alarm_create(function() {
	if (is_local_turn()) {
		with (objLastTurns) {
			event_decided();
		}
	}
});