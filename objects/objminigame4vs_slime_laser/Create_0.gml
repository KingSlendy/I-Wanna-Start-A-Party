depth = objMinigame4vs_Slime_Slime.depth - 1;
image_xscale = -700;
image_yscale = 3;
scale = 3;

alarms_init(1);

alarm_create(function() {
	scale -= 0.1;

	if (scale <= 0) {
		instance_destroy();
		return;
	}

	alarm_frames(0, 1);
});

alarm_call(0, 1);