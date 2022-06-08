with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	move_delay_timer = 0;
	chosed_conveyor = -1;
}

event_inherited();

minigame_start = minigame_1vs3_start;
minigame_time = 40;
minigame_time_end = function() {
	with (objPlayerBase) {
		if (y > 288) {
			minigame_4vs_points(objMinigameController.info, network_id);
			break;
		}
	}
	
	minigame_finish();
}

action_end = function() {
	with (objMinigame1vs3_Conveyor_Conveyor) {
		sprite_index = sprMinigame1vs3_Conveyor_ConveyorStill;
		spd = 0;
	}
	
	alarm[4] = 0;
}

points_draw = true;
points_number = false;
player_check = objPlayerPlatformer;
