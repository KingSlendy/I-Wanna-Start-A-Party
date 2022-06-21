with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 30;
action_end = function() {
	alarm[4] = 0;
	alarm[5] = 0;
}

points_draw = true;
player_check = objPlayerPlatformer;

coin_count = 0;
spike_count = 0;
