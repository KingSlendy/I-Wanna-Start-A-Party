alarms_init(1);

alarm_create(function() {
	image_index = irandom(image_number - 1);
	alarm_call(0, 0.75);
});

alarm_instant(0);