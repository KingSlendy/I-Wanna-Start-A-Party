if (image_alpha != 1) {
	exit;
}

image_alpha = 0.5;
frozen = true;
hspd = 0;
vspd = 0;
alarm_call(0, 1);
alarm_call(1, 2);
audio_play_sound(sndDeath, 0, false);