with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_move = false;
	enable_jump = false;
}

event_inherited();

minigame_start = minigame2vs2_start;
action_end = function() {
	if (trophy_obtain && trophy_shoot) {
		gain_trophy(48);
	}
}

points_draw = true;
player_check = objPlayerPlatformer;

player_can_shoot = array_create(global.player_max, false);
player_shot_time = array_create(global.player_max, 0);
cpu_shot_delay = array_create(global.player_max, 0);
take_time = false;
show_mark = false;
revive = -1;

trophy_obtain = true;
trophy_shoot = false;