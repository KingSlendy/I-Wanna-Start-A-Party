alarms_init(1);

alarm_create(function() {
	var f = instance_create_layer(x, y - 10, "Actors", objMinigame2vs2_Springing_Fireball);
	f.hspeed = random_range(-5, 1);
	f.vspeed = irandom_range(-7, -9);
	f.gravity = 0.25;

	var f = instance_create_layer(x, y - 10, "Actors", objMinigame2vs2_Springing_Fireball);
	f.hspeed = random_range(1, 5);
	f.vspeed = irandom_range(-7, -9);
	f.gravity = 0.25;

	if (objMinigameController.points_teams[0][1].lost && objMinigameController.points_teams[1][1].lost) {
		alarm_call(0, 0.15);
	} else {
		alarm_call(0, 0.25);
	}
});