instance_destroy();

if (instance_number(object_index) + 1 > 1) {
	exit;
}

with (objMinigameController) {
	camera_state = -1;
	alarm_call(4, 1);
}

audio_stop_sound(sndMinigame4vs_Waka_PacMan);