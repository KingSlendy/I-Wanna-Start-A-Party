event_inherited();

minigame_start = minigame2vs2_start;
minigame_players = function() {
	objPlayerPlatformer.enable_shoot = false;
}

points_draw = true;
player_check = objPlayerPlatformer;

reset = -1;

alarm_override(1, function() {
	alarm_inherited(1);
});