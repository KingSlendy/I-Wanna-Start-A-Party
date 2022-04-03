with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	grav_amount = 0;
	enable_shoot = false;
	has_item = false;
	jump_total = -1;
}

event_inherited();

distance_to_win = 16;