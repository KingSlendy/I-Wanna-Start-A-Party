alarms_init(1);

alarm_create(function() {
	var f = instance_create_layer(x, y - 10, "Actors", objMinigame2vs2_Springing_Fireball);
	f.hspeed = random_range(-5, -0.1);
	f.vspeed = irandom_range(-7, -9);
	f.gravity = 0.25;

	audio_play_sound(sndMinigame2vs2_Springing_Fireball, 0, false);

	if (objMinigameController.points_teams[0][0].lost || objMinigameController.points_teams[0][1].lost) {
		alarm_call(0, 0.1);
	} else {
		alarm_call(0, 0.3);
	}
});

alarm_create(function() {
	var f = instance_create_layer(x, y - 10, "Actors", objMinigame2vs2_Springing_Fireball);
	f.hspeed = random_range(0.1, 5);
	f.vspeed = irandom_range(-7, -9);
	f.gravity = 0.25;
	
	audio_play_sound(sndMinigame2vs2_Springing_Fireball, 0, false);
	
	if (objMinigameController.points_teams[1][0].lost || objMinigameController.points_teams[1][1].lost) {
		alarm_call(1, 0.1);
	} else {
		alarm_call(1, 0.3);
	}
});