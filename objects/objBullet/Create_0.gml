if (room == rMinigame4vs_Targets) {
	with (objMinigameController) {
		player_bullets[player_turn - 1] = max(--player_bullets[player_turn - 1], 0);
	}
}

audio_play_sound(sndShoot, 0, false);

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

alarm_frames(0, (room != rMinigame4vs_Rocket) ? 60 : 100);