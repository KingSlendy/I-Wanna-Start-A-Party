var block = instance_place(x, y, objMinigame1vs3_Coins_Reflector);

if (block != noone && vspeed > 1) {
	y = yprevious;

	//Detect vertical collision
	if (place_meeting(x, y + vspeed, objMinigame1vs3_Coins_Reflector)) {
		while (!place_meeting(x, y + sign(vspeed), objMinigame1vs3_Coins_Reflector)) {
			y += sign(vspeed);
		}

		vspeed *= -0.75;
		vspeed = min(vspeed, -2);
	}
}