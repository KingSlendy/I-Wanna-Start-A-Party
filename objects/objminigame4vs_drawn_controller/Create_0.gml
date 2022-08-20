with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_time = 30;
points_draw = true;
player_check = objPlayerPlatformer;