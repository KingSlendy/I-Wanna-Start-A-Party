with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	move_delay_timer = 0;
	chosed_conveyor = -1;
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
	with (objMinigame1vs3_Conveyor_Conveyor) {
		sprite_index = sprMinigame1vs3_Conveyor_ConveyorStill;
		spd = 0;
	}
}

player_check = objPlayerPlatformer;