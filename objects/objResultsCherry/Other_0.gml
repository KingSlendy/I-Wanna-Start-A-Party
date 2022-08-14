if (y > 608) {
	with (objResults) {
		alarm_call(1, 0.5);
	}
	
	instance_destroy();
} else if (vspeed < 0) {
	instance_destroy();
}