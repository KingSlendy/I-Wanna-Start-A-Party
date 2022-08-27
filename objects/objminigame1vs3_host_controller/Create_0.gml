with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_start = minigame1vs3_start;
minigame_camera = CameraMode.Split4;
minigame_time = 15;
minigame_time_valign = fa_top;
minigame_time_end = function() {
	if (hider) {
		lights = false;
		alarm_call(6, 1);
	} else {
		
	}
}

player_check = objPlayerPlatformer;

current_round = 1;
lights = true;
hider = true;
surf = noone;

alarm_override(0, function() {
	alarm_inherited(0);
	music_stop();
	alarm_stop(10);
});

alarm_override(1, function() {
	alarm_call(4, 1);
});

alarm_create(4, function() {
	show_popup("ROUND " + string(current_round));
	alarm_call(5, 2);
});

alarm_create(5, function() {
	music_play(music);
	show_popup("HIDE!",,,,,, 0.25);
	points_teams[1][0].frozen = false;
	minigame_time = 15;
	alarm_call(10, 1);
});

alarm_create(6, function() {
	with (points_teams[1][0]) {
		//draw = false;
		//frozen = true;
	}
	
	lights = true;
});