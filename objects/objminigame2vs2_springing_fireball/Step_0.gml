image_xscale += 0.09;
image_yscale += 0.09;
image_angle += 6;

if (image_xscale >= 2) {
	depth = layer_get_depth("Collisions");
	image_xscale = 2;
	image_yscale = 2;
}