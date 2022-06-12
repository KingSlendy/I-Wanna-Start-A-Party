if (y > 608) {
	objResults.alarm[1] = get_frames(0.5);
	instance_destroy();
} else if (vspeed < 0) {
	instance_destroy();
}
