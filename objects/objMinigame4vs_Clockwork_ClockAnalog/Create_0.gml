hour = 11;
minutes = 56;
target_hour = 0;
target_minutes = 0;

//This determines what sections each digit from 0-9 needs to have turned on.
sections_makes_digits = {};
var smd = sections_makes_digits;

smd[$ 0] = "012456";
smd[$ 1] = "25";
smd[$ 2] = "02346";
smd[$ 3] = "02356";
smd[$ 4] = "1235";
smd[$ 5] = "01356";
smd[$ 6] = "013456";
smd[$ 7] = "025";
smd[$ 8] = "0123456";
smd[$ 9] = "012356";

//This determines what digits need that specific section to be turned on.
sections_contained_digits = {};
var scd = sections_contained_digits;

scd[$ 0] = "02356789";
scd[$ 1] = "045689";
scd[$ 2] = "01234789";
scd[$ 3] = "2345689";
scd[$ 4] = "0268";
scd[$ 5] = "013456789";
scd[$ 6] = "0235689";

//This determines bbox for each section
sections_bbox = {};
var sbb = sections_bbox;
var spr = sprMinigame4vs_Clockwork_DigitalNumber;
var w = sprite_get_width(spr);
var h = sprite_get_height(spr);

for (var i = 0; i < 7; i++) {
	var surf = surface_create(w, h);
	surface_set_target(surf);
	draw_sprite(spr, i, 0, 0);
	surface_reset_target();
	var sprite = sprite_create_from_surface(surf, 0, 0, w, h, false, false, 0, 0);
	sprite_collision_mask(sprite, false, bboxmode_automatic, 0, 0, w - 1, h - 1, bboxkind_precise, 0);
	
	sbb[$ i] = {
		left: sprite_get_bbox_left(sprite),
		right: sprite_get_bbox_right(sprite),
		top: sprite_get_bbox_top(sprite),
		bottom: sprite_get_bbox_bottom(sprite)
	};
	
	sprite_delete(sprite);
	surface_free(surf);
}
	

check_target_time = false;

function clock_analog_tick_minutes(increment) {
	minutes += increment;

	if (minutes >= 60) {
		minutes -= (minutes div 60) * 60;
		hour = (hour + 1) mod 12;
	}
}

function clock_analog_sync_digital() {
	var time = [
		hour div 10,
		hour mod 10,
		minutes div 10,
		minutes mod 10
	];

	with (objMinigame4vs_Clockwork_ClockDigital) {
		for (var i = 0; i < number_digits; i++) {
			for (var j = 0; j < number_sections; j++) {
				numbers[i][j] = (string_contains(other.sections_makes_digits[$ time[i]], string(j)));
			}
		}
	}
}

function clock_analog_random_time() {
	next_seed_inline();
	var prev_target_hour = target_hour;
	var prev_target_minutes = target_minutes;
	
	do {
		target_hour = irandom(11);
		target_minutes = irandom(11) * 5;
	} until (target_hour != prev_target_hour && target_minutes != prev_target_minutes);

	var time = [
		target_hour div 10,
		target_hour mod 10,
		target_minutes div 10,
		target_minutes mod 10
	];

	with (objMinigame4vs_Clockwork_ClockDigital) {
		for (var i = 0; i < number_digits; i++) {
			for (var j = 0; j < number_sections; j++) {
				player.target_numbers[i][j] = (string_contains(other.sections_makes_digits[$ time[i]], string(j)));
			}
		}
	}
	
	target_laps = 2;
	objPlayerBase.frozen = true;
	alarm_frames(0, 1);
	audio_play_sound(sndMinigame4vs_Clockwork_AnalogTock, 0, true);
}

alarms_init(2);

alarm_create(function() {
	clock_analog_tick_minutes(5);

	if (hour == target_hour && minutes == target_minutes) {
		if (--target_laps <= 0) {
			hour = target_hour;
			minutes = target_minutes;
			check_target_time = true;
			
			with (objMinigameController) {
				minigame_time = 20;
				alarm_call(10, 1);
			}
			
			objPlayerBase.frozen = false;
			audio_stop_sound(sndMinigame4vs_Clockwork_AnalogTock);
			exit;
		}
	}

	alarm_frames(0, 1);
});

alarm_create(function() {
	clock_analog_random_time();
});