state = -1;

if (!trial_is_title(BUGS_EVERYWHERE)) {
	spd = 1;
} else {
	spd = 5;	
}

counter = 0;

alarms_init(1);

alarm_create(function() {
	next_seed_inline();
	
	if (!trial_is_title(BUGS_EVERYWHERE)) {
		if (chance(0.2)) {
			hspeed = choose(-spd, spd);
			vspeed = choose(-spd, spd);
		} else {
			hspeed = 0;
			vspeed = 0;
		}
	} else {
		hspeed = irandom_range(-spd, spd);
		vspeed = irandom_range(-spd, spd);
	}
	
	alarm_call(0, random_range(1, 5));
});