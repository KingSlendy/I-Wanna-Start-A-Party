with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
}

event_inherited();

minigame_start = minigame1vs3_start;
minigame_time = 60;
player_check = objPlayerPlatformer;