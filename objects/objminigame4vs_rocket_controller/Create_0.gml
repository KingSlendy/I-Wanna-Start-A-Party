with (objPlayerBase) {
	change_to_object(objPlayerRocket);
}

with (objPlayerBase) {
	hp = 3;
	spd = 0;
}

event_inherited();

minigame_camera = CameraMode.Split4;
player_check = objPlayerRocket;