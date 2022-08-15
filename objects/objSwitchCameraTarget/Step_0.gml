image_alpha -= 0.04 * DELTA;

if (image_alpha <= 0) {
	instance_destroy();
}