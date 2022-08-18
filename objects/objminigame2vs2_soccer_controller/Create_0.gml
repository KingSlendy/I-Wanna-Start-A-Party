with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerPlatformer.enable_shoot = false;

event_inherited();

minigame_start = minigame2vs2_start;
points_draw = true;
player_check = objPlayerPlatformer;

reset = -1;

alarm_override(1, function() {
	alarm_inherited(1);
});