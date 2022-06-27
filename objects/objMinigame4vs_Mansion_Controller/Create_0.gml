with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_jump = false;
	enable_shoot = false;
	door = null;
	fade = -1;
	entered = [];
	target = null;
}

event_inherited();
minigame_camera = CameraMode.Follow;
player_check = objPlayerPlatformer;

trophy_doors = true;
