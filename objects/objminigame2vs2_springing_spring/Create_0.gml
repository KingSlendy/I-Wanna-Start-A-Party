enabled = false;

if (trial_is_title(TINY_TEAMING) && x < 400) {
	image_xscale = 0.2;
	image_yscale = 0.2;
}

alarms_init(1);

alarm_create(function() {
	image_index = 0;
});