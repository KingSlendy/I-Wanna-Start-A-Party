var rnd = irandom(359);

for (var i = 0; i < 360; i += 360 / 20) {
	var a = instance_create_layer(400, 336, "Actors", objMinigame1vs3_Avoid_Cherry);
	a.image_index = attack;
	a.direction = i + rnd;
	a.speed = 6;
	a.dir = dir;
}

dir *= -1;
alarm[0] = 30;
