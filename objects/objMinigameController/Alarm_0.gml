show_popup("START");
announcer_started = true;
music_play(music, true);
audio_play_sound(sndMinigameStart, 0, false);
alarm[1] = get_frames(0.5);

if (minigame_time != -1) {
	alarm[10] = get_frames(1);
}

alarm[11] = 1;
