with (objMinigame1vs3_Conveyor_Spike) {
	if (image_angle == 0) {
		target_x += 32 * ((x < 400) ? 1 : -1);
	}
}

if (++spikes_close == 3) {
	exit;
}

alarm[4] = get_frames(5);
