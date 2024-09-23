vspd = 0;
grav = 0;
alarms_init(3);

alarm_create(function() {
	image_index = 1;
	
	if (objMinigameController.crusher_count < 15) {
		alarm_call(1, 0.5);
	} else {
		alarm_call(1, 0.1);
	}
});

alarm_create(function() {
	image_index = 2;
	vspd = 10;
	grav = 0.2;
});

alarm_create(function() {
	image_index = 3;
	vspd = -5;
});