with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

player_check = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	objMinigame4vs_Blocks_Block.enabled = true;
});