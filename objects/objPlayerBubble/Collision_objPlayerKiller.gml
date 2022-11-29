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

switch (objMinigameController.places[? network_id]) {
	case 1: var recover = 2.0; break;
	case 2: var recover = 1.0; break;
	case 3: var recover = 0.5; break;
	case 4: var recover = 0.1; break;
}

alarm_call(0, recover);
alarm_call(1, recover + 1);
audio_play_sound(sndDeath, 0, false);