event_inherited();
depth = -9003;

target_follow = null;
cloud_mode = 0;
cloud_alpha = 0;
var shines = [];

with (objShine) {
	array_push(shines, id);
}

next_seed_inline();
array_shuffle_ext(shines);
cloud_shine = shines[0];
cloud_x = cloud_shine.x - 64;
cloud_y = cloud_shine.y;
cloud_target_x = cloud_x;

function cloud_start() {
	alarm_call(1, 0.5);
}

alarms_init(4);

alarm_create(function() {
	with (cloud_shine) {
		var vessel = shine_nearest_vessel();
		other.target_follow = {x: vessel.x + 16, y: vessel.y + 16};
	}

	switch_camera_target(target_follow.x, target_follow.y).final_action = cloud_start;
});

alarm_create(function() {
	cloud_mode = 1;
	cloud_target_x = cloud_shine.x;
});

alarm_create(function() {
	with (cloud_shine) {
		losing = true;
		audio_play_sound(sndShineLose, 0, false);
	}
});

alarm_create(function() {
	cloud_mode = -1;
});

alarm_call(0, 0.1);