instance_destroy();

if (instance_number(object_index) + 1 > 1) {
	exit;
}

with (objMinigameController) {
	camera_state = -1;
	
	if (!trial_is_title(WAKA_DODGES)) {
		alarm_call(4, 1);
	} else {
		alarm_next(6);
	}
}

audio_stop_sound(sndMinigame4vs_Waka_PacMan);