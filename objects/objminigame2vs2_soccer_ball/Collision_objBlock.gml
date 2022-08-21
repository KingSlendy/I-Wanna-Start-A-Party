x = xprevious;
y = yprevious;

if (place_meeting(x + hspeed, y, objBlock)) {
	while (!place_meeting(x + sign(hspeed), y, objBlock)) {
		x += sign(hspeed);
	}
	
	hspeed *= -1;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	while (!place_meeting(x, y + sign(vspeed), objBlock)) {
		y += sign(vspeed);
	}
	
	vspeed *= -0.75;
}