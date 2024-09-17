if (y < ystart) {
	y = ystart;
	image_index = 0;
}

yprevious = y;

if (place_meeting(x, y, objBlock)) {
	y = yprevious;
	
	if (place_meeting(x, y + vspeed, objBlock)) {
		while (!place_meeting(x, y + sign(vspeed), objBlock)) {
			y += sign(vspeed);
		}
		
		vspeed = 0;
		alarm_call(2, 1);
	}
}