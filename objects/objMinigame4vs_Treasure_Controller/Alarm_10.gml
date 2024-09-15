if (--minigame_time <= 5) {
	audio_play_sound(sndMinigameCountdown, 0, false);
}

if (minigame_time <= 0) {
	minigame_time = 0;
	
	if (!info.is_finished) {
		minigame_time_end();
	}
	
	exit;
}

alarm[10] = get_frames(1);
