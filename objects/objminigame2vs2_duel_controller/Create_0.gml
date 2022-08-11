with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_move = false;
	enable_jump = false;
}

event_inherited();

minigame_start = minigame2vs2_start;
points_draw = true;
player_check = objPlayerPlatformer;

show_mark = false;