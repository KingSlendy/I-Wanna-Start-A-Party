event_inherited();

if (++chest_round == 4) {
	minigame_finish();
	exit;
}

objMinigame4vs_Chests_Chest.alarm[0] = 1;
chest_started = true;