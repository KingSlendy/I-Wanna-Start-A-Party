dir = x % 360;

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

alarm_frames(0, 15);