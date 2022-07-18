scale = lerp(scale, scale_target, 0.3);

if (scale_target == 0 && point_distance(scale, 0, scale_target, 0) < 0.01) {
	instance_destroy();
}