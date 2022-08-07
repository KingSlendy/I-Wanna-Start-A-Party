with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	chosed_block = -1;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 25;
minigame_time_end = function() {
	if (!minigame1vs3_lost()) {
		minigame1vs3_points();
	} else {
		minigame4vs_points(points_teams[1][0].network_id);
	}
	
	minigame_finish();
}

action_end = function() {
	with (objMinigame1vs3_Avoid_Block) {
		alarm[0] = 0;
		alarm[1] = 0;
		alarm[2] = 0;
		alarm[3] = 0;
	}
	
	instance_destroy(objMinigame1vs3_Avoid_Cherry);
}

player_check = objPlayerPlatformer;