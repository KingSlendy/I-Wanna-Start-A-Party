image_speed = random_range(0.9, 1);
image_index = random(image_number - 1);
next_seed_inline();
image_blend = choose(c_white, c_lime);

alarms_init(1);

alarm_create(function() {
	next_seed_inline();
	image_blend = (image_blend == c_white) ? c_lime : c_white;
	alarm_call(0, random_range(1, 2));
});

alarm_call(0, random_range(1, 2));