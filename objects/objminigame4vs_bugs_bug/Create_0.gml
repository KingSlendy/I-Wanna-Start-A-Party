state = -1;
spd = 5;
counter = 0;

alarms_init(1);

alarm_create(function() {
	next_seed_inline();
	hspeed = irandom_range(-spd, spd);
	vspeed = irandom_range(-spd, spd);
	
	if (!trial_is_title(BUGS_EVERYWHERE)) {
		spd -= 0.5;
		spd = max(spd, 1);
	}
	
	alarm_call(0, random_range(1, 5));
});