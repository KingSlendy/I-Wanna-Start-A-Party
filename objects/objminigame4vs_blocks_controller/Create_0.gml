with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

player_check = objPlayerPlatformer;