with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	max_hspd = 1;
	enable_jump = false;
	enable_shoot = false;
}

event_inherited();
