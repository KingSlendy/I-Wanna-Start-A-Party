with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

event_inherited();

minigame_start = minigame2vs2_start;
player_check = objPlayerPlatformer;
