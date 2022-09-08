if (room == rMinigame4vs_Targets) {
	with (objMinigameController) {
		player_bullets[player_turn - 1] = max(--player_bullets[player_turn - 1], 0);
	}
}

var frames = 60;

if (room == rMinigame4vs_Rocket) {
	frames = 100;
}

audio_play_sound(sndShoot, 0, false);
alarm[0] = frames;