with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	state = -1;
	state_presses = [
		false,
		null,
		[false, 0],
		false,
		[false, false, get_frames(0.5)],
		null,
		false,
		false,
		false,
		null,
		[get_frames(7), 0],
		null,
		false,
		[get_frames(7), 0],
		false
	];
}

event_inherited();

minigame_start = minigame2vs2_start;
minigame_camera = CameraMode.Split4;
player_check = objPlayerPlatformer;