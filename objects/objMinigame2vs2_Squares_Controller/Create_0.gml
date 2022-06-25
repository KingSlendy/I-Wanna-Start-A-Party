with (objPlayerBase) {
	change_to_object(objPlayerStatic);
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_time = 40;
action_end = function() {
	alarm[4] = 0;
	alarm[5] = 0;
}

points_draw = true;
player_check = objPlayerStatic;
