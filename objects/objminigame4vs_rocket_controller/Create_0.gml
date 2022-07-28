with (objPlayerBase) {
	change_to_object(objPlayerRocket);
}

objPlayerBase.hp = 3;

event_inherited();

minigame_camera = CameraMode.Split4;
player_check = objPlayerRocket;