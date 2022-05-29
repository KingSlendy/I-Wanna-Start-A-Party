with (objPlayerBase) {
	change_to_object(objPlayerPlatformer);
}

objPlayerBase.enable_shoot = false;

event_inherited();

minigame_start = minigame_4vs_start;
minigame_split = true;
music = bgmMinigameD;
player_check = objPlayerPlatformer;
