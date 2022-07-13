if (place_meeting(x, y + vspeed, objBlock)) {
	while (!place_meeting(x, y + sign(vspeed), objBlock)) {
		y += sign(vspeed);
	}
	
	vspeed = 0;
	gravity = 0;
}