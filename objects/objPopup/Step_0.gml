if (!disappear) {
	scale = animcurve_channel_evaluate(curve_channel, curve_pos);
	curve_pos += curve_spd;
	
	if (curve_pos > 1) {
		curve_pos = 1;
		curve_spd = 0;
		alarm[0] = get_frames(1.2);
	}
} else {
	scale -= 0.1;
	
	if (scale < 0) {
		instance_destroy();
	}
}