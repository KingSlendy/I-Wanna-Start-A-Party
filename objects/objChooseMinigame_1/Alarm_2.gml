global.choice_selected = (global.choice_selected + 1 + minigame_total) % minigame_total;
audio_play_sound(sndRouletteRoll, 0, false);

minigames_timer += 0.10;

if (minigames_timer > 6 && irandom(1) == 0 && global.choice_selected == minigames_chosen) {
	choosed_minigame();	
	exit;
}

alarm[2] = minigames_timer;
