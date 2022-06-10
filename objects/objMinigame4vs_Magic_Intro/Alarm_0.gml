show_popup(time,, 500,,,, 0.02);
time--;
audio_play_sound(sndMinigameCountdown, 0, false);

if (time == 0) {
	alarm[1] = get_frames(1);
	exit;
}

alarm[0] = get_frames(1);
