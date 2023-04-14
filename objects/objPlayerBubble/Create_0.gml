event_inherited();
xscale = 1;
orientation = 1;
hspd = 0;
vspd = 0;

alarm_create(0, function() {
	if (objMinigameController.info.is_finished) {
		return;
	}
	
	frozen = false;
});

alarm_create(1, function() {
	image_alpha = 1;
});