image_alpha = lerp(image_alpha, 1, 0.1);
image_xscale = lerp(image_xscale, scale_target, 0.1);
image_yscale = image_xscale;

if (scale_target == 0 && point_distance(image_xscale, 0, scale_target, 0) < 0.1) {
	instance_destroy();
	exit;
}

if (image_alpha < 1 && point_distance(image_alpha, 0, 1, 0) < 0.001) {
	image_alpha = 1;
	scale_target = 0;
}