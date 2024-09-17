alarms_init(3);

alarm_create(function() {
	image_index = 1;
	alarm_call(1, 1);
});

alarm_create(function() {
	image_index = 2;
	vspeed = 5;
});

alarm_create(function() {
	image_index = 3;
	vspeed = -2;
});