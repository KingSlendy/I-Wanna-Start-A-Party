if (fading) {
	image_alpha -= 0.04;
	
	if (image_alpha <= 0) {
		image_alpha = 1;
		visible = false;
		fading = false;
	}
	
	exit;
}

if (!circle) {
	var set_x = (target_dir == 1) ? target_x : xstart;
	var set_y = (target_dir == 1) ? target_y : ystart;
	x = approach(x, set_x, spd);
	y = approach(y, set_y, spd);
	
	if (x == set_x && y == set_y) {
		target_dir *= -1;
	}
} else {
	x = xstart + lengthdir_x(50, angle);
	y = ystart + lengthdir_y(50, angle);
	angle = (angle + 360 + spd) % 360;
}