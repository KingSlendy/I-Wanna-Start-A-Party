if (place_meeting(x + hspeed, y, objBlock)) {
	hspeed *= -1;
}

if (place_meeting(x, y + vspeed, objBlock)) {
	vspeed *= -1;
}

if (state == 0) {
	image_xscale += 0.07;
	image_yscale += 0.07;
	
	if (image_xscale >= 2) {
		image_xscale = 2;
		image_yscale = 2;
		state = 1;
	}
} else if (state == 1) {
	image_xscale -= 0.07;
	image_yscale -= 0.07;
	
	if (image_xscale <= 0) {
		instance_destroy();
	}
}