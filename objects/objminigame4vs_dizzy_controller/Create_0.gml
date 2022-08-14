with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

with (objPlayerBase) {
	grav_amount = 0;
	enable_shoot = false;
	has_item = false;
	last_touched = null;
}

event_inherited();

player_check = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.8;
});