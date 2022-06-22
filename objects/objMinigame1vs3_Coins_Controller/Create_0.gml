with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	hittable = true;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 30;
minigame_time_end = function() {
	if (trophy_hit && focus_player_by_id(global.player_id).x > 192) {
		gain_trophy(15);
	}
	
	minigame_finish();
}

action_end = function() {
	alarm[4] = 0;
	alarm[5] = 0;
}

points_draw = true;
player_check = objPlayerPlatformer;

coin_count = 0;
spike_count = 0;

trophy_hit = true;
