image_alpha = lerp(image_alpha, alpha_target, 0.3);

if (alpha_target == 0 && point_distance(image_alpha, 0, alpha_target, 0) < 0.01) {
	instance_destroy();
	exit;
}