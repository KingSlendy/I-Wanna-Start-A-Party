event_inherited();

minigame_players = function() {
	with (objPlayerBase) {
		grav_amount = 0;
		enable_shoot = false;
		has_item = false;
		last_touched = null;
	}
}

player_type = objPlayerPlatformer;
trophy_none = true;

alarm_override(1, function() {
	alarm_inherited(1);
	objPlayerBase.grav_amount = 0.8;
});