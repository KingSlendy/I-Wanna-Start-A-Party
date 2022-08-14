if (!disappear) {
	scale = animcurve_channel_evaluate(curve_channel, curve_pos);
	curve_pos += curve_spd;
	
	if (curve_pos > 1) {
		curve_pos = 1;
		curve_spd = 0;
		alarm_call(0, time);
	}
} else {
	scale -= 0.1;
	
	if (scale < 0) {
		instance_destroy();
	}
}