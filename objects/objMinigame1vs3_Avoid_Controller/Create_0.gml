with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	chosed_block = -1;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 30;
minigame_time_end = function() {
	with (objPlayerBase) {
		if (y > 128) {
			minigame4vs_points(objMinigameController.info, network_id);
			break;
		}
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

points_draw = true;
points_number = false;
player_check = objPlayerPlatformer;
