if (distance_to_object(objPlayerBase) < 6 && objPlayerBase.spinning) {
	smash();
	exit;
}

yprevious = y;

if (place_meeting(x, y, objBlock)) {
	y = yprevious;
	
	if (place_meeting(x, y + vspeed, objBlock)) {
		while (!place_meeting(x, y + sign(vspeed), objBlock)) {
			y += sign(vspeed);
		}
		
		vspeed = 0;
		gravity = 0;
	}
}