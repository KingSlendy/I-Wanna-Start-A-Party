info = global.minigame_info;

with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	enable_shoot = false;
	frozen = true;
	has_item = false;
	jump_total = -1;
}

alarm[1] = get_frames(1);