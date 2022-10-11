fade_start = -1;
fade_alpha = 0;

surf = noone;
surf2 = noone;

view_visible[6] = true;
view_wport[6] = 416;
view_hport[6] = 320;
var camera = view_camera[6];
camera_set_view_size(camera, 416, 320);
camera_set_view_pos(camera, 1600 + 192, 128);
show_view_x = 0;
show_view_y = 0;

view_visible[7] = true;
view_wport[7] = 800;
view_hport[7] = 608;
var camera = view_camera[7];
camera_set_view_size(camera, 800, 608);
camera_set_view_pos(camera, 800, 0);
draw_views = true;

time = 3;
quake = false;
fall_order = array_sequence(0, 10);
fall_current = 0;
array_shuffle(fall_order);

alarms_init(12);

alarm_create(function() {
	show_popup(time,, 500,,,, 0.02);
	time--;
	audio_play_sound(sndMinigameCountdown, 0, false);

	if (time == 0) {
		alarm_call(1, 1);
		return;
	}

	alarm_call(0, 1);
});

alarm_create(function() {
	quake = true;
	audio_play_sound(sndMinigame4vs_Magic_Quake, 0, true);
	alarm_call(2, 1);
});

alarm_create(function() {
	next_seed_inline();

	with (objMinigame4vs_Magic_Items) {
		if (order == other.fall_order[other.fall_current]) {
			hspd = choose(-3, -2, 2, 3);
			grav = random_range(0.1, 0.3);
		}
	}

	audio_play_sound(sndMinigame4vs_Magic_Fall, 0, false);

	if (++fall_current == 10) {
		alarm_call(3, 1);
		return;
	}
	
	alarm_call(2, 0.2);
});

alarm_create(function() {
	quake = false;
	audio_stop_sound(sndMinigame4vs_Magic_Quake);
	alarm_call(4, 1);
});

alarm_create(function() {
	fade_start = 2;
});

alarm_create(11, function() {
	music_play(objMinigameController.music);
});

alarm_call(11, 1);
alarm_call(0, 3);