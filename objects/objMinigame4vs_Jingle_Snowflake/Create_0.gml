hspeed = 6;

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

alarm_call(0, 0.5);