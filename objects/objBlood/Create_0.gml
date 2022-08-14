image_index = irandom(image_number - 1);
image_speed = 0;

speed = 6;
gravity = 0.2;

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

alarm_call(0, 3);