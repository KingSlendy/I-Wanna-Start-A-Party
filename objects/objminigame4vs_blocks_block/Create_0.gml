enabled = false;
active = false;

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});