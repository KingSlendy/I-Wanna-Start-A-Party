event_inherited();

minigame_players = function() {
	objPlayerBase.enable_shoot = false;
}

player_type = objPlayerPlatformer;

alarm_override(1, function() {
	alarm_inherited(1);
	objMinigame4vs_Blocks_Block.enabled = true;
});