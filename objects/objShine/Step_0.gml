if (spawning) {
	image_xscale += 0.03;
	image_yscale += 0.03;
	
	if (image_xscale >= 1) {
		image_xscale = 1;
		image_yscale = 1;
	}
	
	y = lerp(y, ystart - 50, 0.1);
	
	if (point_distance(x, y, x, ystart - 50) < 1) {
		spawning = false;
		floating = true;
	}
}

if (getting) {
	image_xscale -= 0.03;
	image_yscale -= 0.03;
	
	if (image_xscale <= 0) {
		objShineChange.alarm[11] = 1;
		instance_destroy();
	}
	
	vspeed = 1;
}