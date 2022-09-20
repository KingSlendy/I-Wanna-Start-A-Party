event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		image_xscale = 2;
		image_yscale = 2;
		touched = false;
	}
}

minigame_time = 30;
action_end = function() {
	alarm_stop(4);
}

points_draw = true;
player_check = objPlayerDir8;

alarm_override(1, function() {
	alarm_inherited(1);
	alarm_instant(4);
});

alarm_create(4, function() {
	for (var r = 0; r < 5; r++) {
		for (var c = 0; c < 5; c++) {
			instance_create_layer(320 + 32 * c, 224 + 32 * r, "Actors", objMinigame4vs_Sky_Save);
		}
	}
	
	objPlayerBase.touched = false;
	alarm_call(4, 2);
});