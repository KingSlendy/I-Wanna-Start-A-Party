with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerPlatformer) {
	xscale = (x < 400) ? 1 : -1;
	enable_shoot = false;
}

event_inherited();

minigame_start = minigame2vs2_start;
player_check = objPlayerPlatformer;