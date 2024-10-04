image_alpha -= 0.08;
image_xscale += 0.05;
image_yscale += 0.05;

if (image_alpha <= 0) {
	instance_destroy();
}