if (image_alpha != 1 || objMinigameController.info.is_finished) {
	exit;
}

image_alpha = 0.5;
frozen = true;
hspd = 0;
vspd = 0;

if (network_id == global.player_id) {
	objMinigameController.trophy_hitless = false;
}

alarm_call(0, 1);
alarm_call(1, 2);
audio_play_sound(sndDeath, 0, false);