if (circle) {
	x = circle_x + lengthdir_x(circle_distance, circle_angle);
	y = circle_y + lengthdir_y(circle_distance, circle_angle);
} else {
	if (!explosion_fade) {
		if (point_distance(xstart, ystart, x, y) >= explosion_distance) {
			x = xstart + lengthdir_x(explosion_distance, explosion_angle);
			y = ystart + lengthdir_y(explosion_distance, explosion_angle);
			speed = 0;
			explosion_fade = true;
		}
	} else {
		image_alpha -= 0.2;
		
		if (image_alpha <= 0) {
			instance_destroy();
		}
	}
}