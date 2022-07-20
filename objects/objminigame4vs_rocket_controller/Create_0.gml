with (objPlayerBase) {
	change_to_object(objPlayerRocket);
}

event_inherited();

minigame_camera = CameraMode.Split4;
player_check = objPlayerRocket;